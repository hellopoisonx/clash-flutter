import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile.g.dart';
part 'profile.freezed.dart';

@Freezed(toJson: true, fromJson: true, equal: true, copyWith: true)
class Profile with _$Profile {
  const factory Profile(
      {required String name,
      required String path,
      // subscription-userinfo
      int? totalTraffic,
      int? uploadTraffic,
      int? downloadTraffic,
      int? freeTraffic,
      String? url,
      DateTime? expirationTime,
      //
      required DateTime createdTime}) = _Profile;

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);
}
