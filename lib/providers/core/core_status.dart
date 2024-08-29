import 'dart:io';

import 'package:clash_core/clash_core.dart';
import 'package:clash_flutter/exception/exception.dart';
import 'package:clash_flutter/models/configs/configs.dart';
import 'package:clash_flutter/models/profiles/profiles.dart';
import 'package:clash_flutter/models/settings/settings.dart';
import 'package:clash_flutter/providers/apis/apis.dart';
import 'package:path/path.dart' as p;
import 'package:clash_flutter/constants/constants.dart';
import 'package:hive/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'core_status.g.dart';

@riverpod
CoreStatus coreStatus(CoreStatusRef ref) {
  try {
    Constants.hivePath = "/etc/clash-flutter"; // for linux
    Directory(Constants.hivePath).createSync();
    Hive.defaultDirectory = Constants.hivePath;
    Constants.defaultHomeDir = Constants.hivePath;
    Constants.defaultProfilePath =
        p.join(Constants.defaultHomeDir, "config.yaml");
    Hive.registerAdapter("Settings", (dynamic json) => Settings.fromJson(json));
    Hive.registerAdapter("Profiles", (dynamic json) => Profiles.fromJson(json));
    Hive.registerAdapter("Configs", (dynamic json) => Configs.fromJson(json));
    final settings = Settings.settings;
    clashCore.setHomeDir(Directory(settings.homeDir));
    clashCore.setProfilePath(Profiles.profiles.currentProfilePath);
    clashCore.setExternalControllerAddress(
        "${settings.externalControllerBaseAddress}:${settings.externalControllerPort}");
    final status = clashCore.launch();
    if (status == CoreStatus.err) {
      throw Exception();
    }
    final conf = Configs.configs;
    ref.read(apisProvider.future).then((apis) => apis.patchConfigs(conf));
    return status;
  } catch (e) {
    MyException.show(error: e, recover: ref.invalidateSelf);
    return CoreStatus.shutdown;
  }
}
