import 'dart:async';
import 'dart:convert';
import 'package:path/path.dart' as p;
import 'dart:io';

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
  ClashCore._();
  static ClashCore? _instance;
  static ClashCore get instance => _instance ??= ClashCore._();

  CoreStatus _status = CoreStatus.shutdown;
  StreamController<CoreStatus> status = StreamController();
  Process? _process;
  late Directory _homeDir;
  late String _profilePath;
  late String _externalControllerAddress;
  Stream<String>? stdout;
  Stream<String>? stderr;

  void _updateStatus(CoreStatus s) {
    _status = s;
    status.add(s);
  }

  void setExternalControllerAddress(String addr) =>
      _externalControllerAddress = addr;

  Future<void> setHomeDir(Directory dir) async {
    _homeDir = dir;
  }

  Future<void> setProfilePath(String path) async {
    _profilePath = path;
    final File file = File(path);
    if (!(await file.exists())) {
      await file.create();
      await file.writeAsString(_defaultConfigTemplate);
    }
    await File(path).copy(p.join(_homeDir.path, "config.yaml"));
  }

  Future<void> launch([bool isAdmin = false]) async {
    if (_status == CoreStatus.running) {
      print("Core is running");
      return;
    }
    print("launching");
    await File.fromUri(Uri.file(_profilePath)).create();
    if (!_homeDir.existsSync()) {
      throw Exception("Home Directory doesn't exist");
    }
    _process = await Process.start(
        "clash-meta",
        [
          "-d",
          _homeDir.path,
          "-f",
          p.join(_homeDir.path, "config.yaml"),
          "-ext-ctl",
          _externalControllerAddress,
        ],
        mode: ProcessStartMode.normal);
    _process?.exitCode.then((code) {
      if (code > 0) _updateStatus(CoreStatus.err);
      if (code == 0) _updateStatus(CoreStatus.running);
      if (code < 0) _updateStatus(CoreStatus.shutdown);
    });
    stdout = _process?.stdout.transform(utf8.decoder);
    stderr = _process?.stderr.transform(utf8.decoder)?..forEach(print);
    _updateStatus(CoreStatus.running);
  }

  Future<void> shutdown() async {
    if (_status != CoreStatus.running) {
      print("Core is not running, cancel shutting down");
      return;
    }
    print("Shuting down");
    final result = _process?.kill();
    if (!(result ?? false)) {
      _updateStatus(CoreStatus.err);
      throw Exception("Failed to kill the core process");
    }
    _updateStatus(CoreStatus.shutdown);
  }

  Future<void> reboot() async {
    if (_status != CoreStatus.running) {
      print("first launch");
      await launch();
    } else {
      await shutdown();
      await launch();
    }
  }
}
