import 'dart:io';

import 'package:clash_core/clash_core.dart';
import 'package:clash_flutter/models/profiles/profile.dart';
import 'package:clash_flutter/models/profiles/profiles.dart' as p;
import 'package:clash_flutter/providers/connections/connections.dart';
import 'package:clash_flutter/providers/logs/logs.dart';
import 'package:clash_flutter/providers/proxies/proxies.dart';
import 'package:clash_flutter/providers/rules/rules.dart';
import 'package:clash_flutter/providers/traffics/traffics.dart';
import 'package:hive/hive.dart';
import 'package:path/path.dart' as path;
import 'package:file_picker/file_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profiles.g.dart';

@riverpod
class Profiles extends _$Profiles {
  @override
  p.Profiles build() {
    return p.Profiles.profiles;
  }

  Future<void> switchProfile(String path) async {
    state = state.copyWith(currentProfilePath: path);
    syncToHive();
    await clashCore.setProfilePath(path);
    await clashCore.reboot();
    ref.invalidate(proxiesProvider);
    ref.invalidate(stdoutProvider);
    ref.invalidate(rulesProvider);
    ref.invalidate(trafficsProvider);
    ref.invalidate(connectionsProvider);
    ref.invalidateSelf();
  }

  Future<void> importFromLocal() async {
    String? result = (await FilePicker.platform.pickFiles())?.files.single.path;
    if (result == null) {
      return;
    }
    DateTime t = await File(result).lastModified();
    state = state.copyWith(currentProfilePath: result, all: [
      ...state.all,
      Profile(
        name: path.split(result).last,
        path: result,
        createdTime: t,
      )
    ]);
    syncToHive();
    await switchProfile(result);
  }

  void syncToHive() {
    final box = Hive.box(name: "clash_flutter");
    box.put("profiles", state);
  }
}
