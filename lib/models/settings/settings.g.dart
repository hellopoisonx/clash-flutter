// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SettingsImpl _$$SettingsImplFromJson(Map<String, dynamic> json) =>
    _$SettingsImpl(
      delayTestURL: json['delayTestURL'] as String? ??
          "https://www.gstatic.com/generate_204",
      delayTiemout: (json['delayTiemout'] as num?)?.toInt() ?? 2000,
      homeDir:
          const SettingsHomeDirConverter().fromJson(json['homeDir'] as String),
      externalControllerBaseAddress:
          json['externalControllerBaseAddress'] as String? ?? "127.0.0.1",
      externalControllerPort:
          (json['externalControllerPort'] as num?)?.toInt() ?? 9090,
    );

Map<String, dynamic> _$$SettingsImplToJson(_$SettingsImpl instance) =>
    <String, dynamic>{
      'delayTestURL': instance.delayTestURL,
      'delayTiemout': instance.delayTiemout,
      'homeDir': const SettingsHomeDirConverter().toJson(instance.homeDir),
      'externalControllerBaseAddress': instance.externalControllerBaseAddress,
      'externalControllerPort': instance.externalControllerPort,
    };
