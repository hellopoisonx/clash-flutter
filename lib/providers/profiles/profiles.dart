import 'dart:io';

import 'package:clash_core/clash_core.dart';
import 'package:clash_flutter/constants/constants.dart';
import 'package:clash_flutter/exception/exception.dart';
import 'package:clash_flutter/models/profiles/profile.dart';
import 'package:clash_flutter/models/profiles/profiles.dart' as p;
import 'package:clash_flutter/models/settings/settings.dart';
import 'package:clash_flutter/providers/commons/commons.dart';
import 'package:clash_flutter/providers/core/core_status.dart';
import 'package:hive/hive.dart';
import 'package:path/path.dart' as p;
import 'package:file_picker/file_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profiles.g.dart';

@riverpod
class Profiles extends _$Profiles {
  @override
  p.Profiles build() {
    ref.watch(coreStatusProvider);
    return p.Profiles.profiles;
  }

  void switchProfile(Profile profile) {
    if (!state.all.contains(profile)) {
      state = state.copyWith(
          currentProfilePath: profile.path, all: [...state.all, profile]);
    } else {
      state = state.copyWith(currentProfilePath: profile.path);
    }
    syncToHive();
    clashCore.setProfilePath(profile.path);
    ref.invalidate(coreStatusProvider);
    ref.invalidateSelf();
  }

  void deleteProfile(Profile profile) {
    if (state.currentProfilePath == profile.path) {
      var profiles = [...state.all];
      profiles.remove(profile);
      state = state.copyWith(
          currentProfilePath: Constants.defaultProfilePath, all: profiles);
      syncToHive();
      clashCore.setProfilePath(state.currentProfilePath);
      ref.invalidate(coreStatusProvider);
    } else {
      var profiles = [...state.all];
      profiles.remove(profile);
      state = state.copyWith(all: profiles);
      syncToHive();
    }
    File(profile.path).deleteSync();
    ref.invalidateSelf();
  }

  Future<void> importFromLocal() async {
    String? path = (await FilePicker.platform.pickFiles())?.files.single.path;
    if (path == null) {
      return;
    }
    DateTime t = await File(path).lastModified();
    try {
      clashCore.testProfile(path);
    } catch (e) {
      await MyException(error: e).show();
      return;
    }
    switchProfile(Profile(
      name: p.split(path).last,
      path: path,
      createdTime: t,
    ));
  }

  Future<void> importFromURL(String url) async {
    final apis = await ref.getApis();
    final profile = await apis.downloadProfile(url, Settings.settings.homeDir);
    try {
      clashCore.testProfile(profile.path);
    } catch (e) {
      print("error: $e");
      File(profile.path).deleteSync();
      throw MyException(error: e);
    }
    switchProfile(profile);
  }

  void syncToHive() {
    final box = Hive.box(name: "clash_flutter");
    box.put("profiles", state);
  }
}
