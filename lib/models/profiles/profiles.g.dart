// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profiles.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProfilesImpl _$$ProfilesImplFromJson(Map<String, dynamic> json) =>
    _$ProfilesImpl(
      all: (json['all'] as List<dynamic>)
          .map((e) => Profile.fromJson(e as Map<String, dynamic>))
          .toList(),
      currentProfilePath: json['currentProfilePath'] as String,
    );

Map<String, dynamic> _$$ProfilesImplToJson(_$ProfilesImpl instance) =>
    <String, dynamic>{
      'all': instance.all,
      'currentProfilePath': instance.currentProfilePath,
    };
