import 'package:clash_flutter/constants/constants.dart';
import 'package:path/path.dart' as p;
import 'package:clash_flutter/models/profiles/profile.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'profiles.g.dart';
part 'profiles.freezed.dart';

@Freezed(toJson: true, fromJson: true, equal: true, copyWith: true)
class Profiles with _$Profiles {
  const Profiles._();
  const factory Profiles({
    required List<Profile> all,
    required String currentProfilePath,
  }) = _Profiles;

  factory Profiles.fromJson(Map<String, dynamic> json) =>
      _$ProfilesFromJson(json);

  static Profiles get profiles {
    final box = Hive.box(name: "clash_flutter");
    final Profiles profiles = box.get(
      "profiles",
      defaultValue: Profiles(all: [
        Profile(
          name: p.split(Constants.defaultProfilePath).last,
          path: Constants.defaultProfilePath,
          createdTime: DateTime.now(),
        )
      ], currentProfilePath: Constants.defaultProfilePath),
    );
    box.put("profiles", profiles);
    return profiles;
  }
}
