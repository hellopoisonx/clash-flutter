import 'dart:ffi' as ffi;
import 'dart:io';

import 'package:clash_core/src/clash_core_generated_bindings.dart';
import 'package:ffi/ffi.dart';

const String _defaultConfigTemplate = """
mixed-port: 7890
allow-lan: true
mode: rule
log-level: info
external-controller: 127.0.0.1:9090
proxy-groups:
  - name: Default
    type: select
    proxies:
      - DIRECT
""";

final clashCore = ClashCore.instance;

enum CoreStatus {
  err,
  running,
  shutdown;
}

class ClashCore {
  ClashCore._() {
    _bindings = ClashCoreBindings(
        ffi.DynamicLibrary.open("libclash-meta$_extPlatform"));
  }

  static String get _extPlatform => Platform.isLinux || Platform.isAndroid
      ? ".so"
      : Platform.isMacOS
          ? ".dylib"
          : Platform.isWindows
              ? ".lib"
              : throw Exception("The platform is not supported");

  static ClashCore? _instance;
  static ClashCore get instance => _instance ??= ClashCore._();

  late final ClashCoreBindings _bindings;
  CoreStatus _status = CoreStatus.shutdown;

  late String _externalControllerAddress;
  //StreamController<String> stdout = StreamController();

  void setExternalControllerAddress(String addr) {
    _externalControllerAddress = addr;
  }

  void setHomeDir(Directory dir) {
    if (!dir.existsSync()) {
      throw Exception("Home Directory doesn't exist");
    }
    final s = dir.path.toNativeUtf8().cast<ffi.Char>();
    _bindings.SetHomeDir(s);
    calloc.free(s);
  }

  void setProfilePath(String path) {
    final File file = File(path);
    if (!file.existsSync()) {
      file.createSync();
      file.writeAsStringSync(_defaultConfigTemplate);
    }
    final s = path.toNativeUtf8();
    final result = _bindings.TestConfig(s.cast()).cast<Utf8>().toDartString();
    if (result.isNotEmpty) {
      calloc.free(s);
      throw Exception("Config contains errors: $result");
    }
    _bindings.SetConfig(s.cast());
    calloc.free(s);
  }

  void testProfile(String path) {
    final s = path.toNativeUtf8();
    final result = _bindings.TestConfig(s.cast()).cast<Utf8>().toDartString();
    if (result.isNotEmpty) {
      calloc.free(s);
      throw Exception("Config contains errors: $result");
    }
    calloc.free(s);
  }

  Future<void> updateGeoDatabase() async {
    final result = _bindings.UpdateGeoDatabases().cast<Utf8>().toDartString();
    if (result.isNotEmpty) {
      throw Exception(result);
    }
  }

  CoreStatus launch([bool isAdmin = false]) {
    if (_status == CoreStatus.running) {
      print("Core is rebooting");
      shutdown();
    }
    print("launching");
    final result = _bindings.StartCore().cast<Utf8>().toDartString();
    if (result.isNotEmpty) {
      _status = CoreStatus.err;
      throw Exception(result);
    }
    final ext = _externalControllerAddress.toNativeUtf8().cast<ffi.Char>();
    _bindings.StartExternalController(ext);
    calloc.free(ext);
    _status = CoreStatus.running;
    return _status;
  }

  void shutdown() async {
    if (_status != CoreStatus.running) {
      print("Core is not running, cancel shutting down");
      return;
    }
    print("Shuting down");
    _bindings.StopCore();
    _status = CoreStatus.shutdown;
  }

  void reboot() {
    if (_status != CoreStatus.running) {
      print("first launch");
      launch();
    } else {
      shutdown();
      launch();
    }
  }
}
