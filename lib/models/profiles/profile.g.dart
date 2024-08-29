// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProfileImpl _$$ProfileImplFromJson(Map<String, dynamic> json) =>
    _$ProfileImpl(
      name: json['name'] as String,
      path: json['path'] as String,
      totalTraffic: const TrafficJsonConverter()
          .fromJson((json['totalTraffic'] as num?)?.toInt()),
      uploadTraffic: const TrafficJsonConverter()
          .fromJson((json['uploadTraffic'] as num?)?.toInt()),
      downloadTraffic: const TrafficJsonConverter()
          .fromJson((json['downloadTraffic'] as num?)?.toInt()),
      url: json['url'] as String?,
      expirationTime: json['expirationTime'] == null
          ? null
          : DateTime.parse(json['expirationTime'] as String),
      createdTime: DateTime.parse(json['createdTime'] as String),
    );

Map<String, dynamic> _$$ProfileImplToJson(_$ProfileImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'path': instance.path,
      'totalTraffic':
          const TrafficJsonConverter().toJson(instance.totalTraffic),
      'uploadTraffic':
          const TrafficJsonConverter().toJson(instance.uploadTraffic),
      'downloadTraffic':
          const TrafficJsonConverter().toJson(instance.downloadTraffic),
      'url': instance.url,
      'expirationTime': instance.expirationTime?.toIso8601String(),
      'createdTime': instance.createdTime.toIso8601String(),
    };
