import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:traffic/traffic.dart';

part 'profile.g.dart';
part 'profile.freezed.dart';

@Freezed(toJson: true, fromJson: true, equal: true, copyWith: true)
class Profile with _$Profile {
  const factory Profile(
      {required String name,
      required String path,
      // subscription-userinfo
      @TrafficJsonConverter() Traffic? totalTraffic,
      @TrafficJsonConverter() Traffic? uploadTraffic,
      @TrafficJsonConverter() Traffic? downloadTraffic,
      String? url,
      DateTime? expirationTime,
      //
      required DateTime createdTime}) = _Profile;

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);
}

class TrafficJsonConverter implements JsonConverter<Traffic?, int?> {
  const TrafficJsonConverter();

  @override
  Traffic? fromJson(int? json) =>
      json != null ? Traffic.fromByte(byte: json) : null;

  @override
  int? toJson(Traffic? object) => object?.byte;
}
