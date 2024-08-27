import 'package:clash_flutter/constants/constants.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'settings.g.dart';
part 'settings.freezed.dart';

@Freezed(toJson: true, fromJson: true, equal: true, copyWith: true)
class Settings with _$Settings {
  const Settings._();
  const factory Settings({
    @Default("https://www.gstatic.com/generate_204") String delayTestURL,
    @Default(2000) int delayTiemout,
    @SettingsHomeDirConverter() required String homeDir,
    @Default("127.0.0.1") String externalControllerBaseAddress,
    @Default(9090) int externalControllerPort,
  }) = _Settings;

  factory Settings.fromJson(Map<String, dynamic> json) =>
      _$SettingsFromJson(json);

  static Settings get settings {
    final box = Hive.box(name: "clash_flutter");
    final Settings? settings = box.get("settings", defaultValue: null);
    if (settings == null) {
      final s = Settings.fromJson({"homeDir": ""});
      box.put("settings", s);
      return s;
    } else {
      return settings;
    }
  }
}

class SettingsHomeDirConverter implements JsonConverter<String, String> {
  const SettingsHomeDirConverter();
  @override
  String fromJson(String path) {
    if (path.isEmpty) {
      return _defaultHomeDir;
    } else {
      return path;
    }
  }

  @override
  String toJson(String object) {
    return object;
  }

  static String get _defaultHomeDir => Constants.defaultHomeDir;
}

class SettingsProfilePathConverter implements JsonConverter<String, String> {
  const SettingsProfilePathConverter();
  @override
  String fromJson(String path) {
    if (path.isEmpty) {
      return _defaultProfilePath;
    } else {
      return path;
    }
  }

  @override
  String toJson(String object) {
    return object;
  }

  static String get _defaultProfilePath => Constants.defaultProfilePath;
}
