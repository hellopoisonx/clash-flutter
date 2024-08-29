// AUTO GENERATED FILE, DO NOT EDIT.
//
// Generated by `package:ffigen`.
// ignore_for_file: type=lint
import 'dart:ffi' as ffi;

class ClashCoreBindings {
  /// Holds the symbol lookup function.
  final ffi.Pointer<T> Function<T extends ffi.NativeType>(String symbolName)
      _lookup;

  /// The symbols are looked up in [dynamicLibrary].
  ClashCoreBindings(ffi.DynamicLibrary dynamicLibrary)
      : _lookup = dynamicLibrary.lookup;

  /// The symbols are looked up with [lookup].
  ClashCoreBindings.fromLookup(
      ffi.Pointer<T> Function<T extends ffi.NativeType>(String symbolName)
          lookup)
      : _lookup = lookup;

  void SetHomeDir(
    ffi.Pointer<ffi.Char> path,
  ) {
    return _SetHomeDir(
      path,
    );
  }

  late final _SetHomeDirPtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<ffi.Char>)>>(
          'SetHomeDir');
  late final _SetHomeDir =
      _SetHomeDirPtr.asFunction<void Function(ffi.Pointer<ffi.Char>)>();

  void SetConfig(
    ffi.Pointer<ffi.Char> path,
  ) {
    return _SetConfig(
      path,
    );
  }

  late final _SetConfigPtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<ffi.Char>)>>(
          'SetConfig');
  late final _SetConfig =
      _SetConfigPtr.asFunction<void Function(ffi.Pointer<ffi.Char>)>();

  ffi.Pointer<ffi.Char> TestConfig(
    ffi.Pointer<ffi.Char> path,
  ) {
    return _TestConfig(
      path,
    );
  }

  late final _TestConfigPtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Char> Function(ffi.Pointer<ffi.Char>)>>('TestConfig');
  late final _TestConfig = _TestConfigPtr.asFunction<
      ffi.Pointer<ffi.Char> Function(ffi.Pointer<ffi.Char>)>();

  ffi.Pointer<ffi.Char> UpdateGeoDatabases() {
    return _UpdateGeoDatabases();
  }

  late final _UpdateGeoDatabasesPtr =
      _lookup<ffi.NativeFunction<ffi.Pointer<ffi.Char> Function()>>(
          'UpdateGeoDatabases');
  late final _UpdateGeoDatabases =
      _UpdateGeoDatabasesPtr.asFunction<ffi.Pointer<ffi.Char> Function()>();

  void StartExternalController(
    ffi.Pointer<ffi.Char> addr,
  ) {
    return _StartExternalController(
      addr,
    );
  }

  late final _StartExternalControllerPtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<ffi.Char>)>>(
          'StartExternalController');
  late final _StartExternalController = _StartExternalControllerPtr.asFunction<
      void Function(ffi.Pointer<ffi.Char>)>();

  ffi.Pointer<ffi.Char> StartCore() {
    return _StartCore();
  }

  late final _StartCorePtr =
      _lookup<ffi.NativeFunction<ffi.Pointer<ffi.Char> Function()>>(
          'StartCore');
  late final _StartCore =
      _StartCorePtr.asFunction<ffi.Pointer<ffi.Char> Function()>();

  void StopCore() {
    return _StopCore();
  }

  late final _StopCorePtr =
      _lookup<ffi.NativeFunction<ffi.Void Function()>>('StopCore');
  late final _StopCore = _StopCorePtr.asFunction<void Function()>();
}

final class max_align_t extends ffi.Opaque {}

final class _GoString_ extends ffi.Struct {
  external ffi.Pointer<ffi.Char> p;

  @ptrdiff_t()
  external int n;
}

typedef ptrdiff_t = ffi.Long;
typedef Dartptrdiff_t = int;

final class GoInterface extends ffi.Struct {
  external ffi.Pointer<ffi.Void> t;

  external ffi.Pointer<ffi.Void> v;
}

final class GoSlice extends ffi.Struct {
  external ffi.Pointer<ffi.Void> data;

  @GoInt()
  external int len;

  @GoInt()
  external int cap;
}

typedef GoInt = GoInt64;
typedef GoInt64 = ffi.LongLong;
typedef DartGoInt64 = int;

const int NULL = 0;
