import 'dart:io';

import 'package:clash_core/clash_core.dart';
import 'package:clash_flutter/exception/exception.dart';
import 'package:clash_flutter/models/configs/configs.dart';
import 'package:clash_flutter/models/profiles/profiles.dart';
import 'package:clash_flutter/models/settings/settings.dart';
import 'package:clash_flutter/providers/apis/apis.dart';
import 'package:clash_flutter/providers/logs/logs.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as p;
import 'package:clash_flutter/constants/constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'core_status.g.dart';

@riverpod
Future<CoreStatus> coreStatus(CoreStatusRef ref) async {
  bool didDispose = false;
  await Future.delayed(const Duration(milliseconds: 500));
  ref.onDispose(() => didDispose = true);
  if (didDispose) {
    throw MyException(error: "Too much request...Cancelling");
  }
  Constants.hivePath = (await getApplicationSupportDirectory()).path;
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
  if (!File(p.join(settings.homeDir, "Country.mmdb")).existsSync()) {
    await File(p.join(settings.homeDir, "Country.mmdb")).writeAsBytes(
        Uint8List.sublistView(await rootBundle.load("assets/Country.mmdb")));
  }
  //clashCore
  //    .updateGeoDatabase()
  //    .catchError(((error) => MyException(error: error).show()));
  clashCore.setExternalControllerAddress(
      "${settings.externalControllerBaseAddress}:${settings.externalControllerPort}");
  final status = clashCore.launch();
  if (status == CoreStatus.err) {
    throw Exception();
  }
  final conf = Configs.configs;
  final apis = await ref.read(apisProvider(false).future);
  await apis.patchConfigs(conf);
  ref.read(logsProvider);
  return status;
}
