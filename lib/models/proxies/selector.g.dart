// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selector.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SelectorImpl _$$SelectorImplFromJson(Map<String, dynamic> json) =>
    _$SelectorImpl(
      name: json['name'] as String,
      now: json['now'] as String,
      all: (json['all'] as List<dynamic>).map((e) => e as String).toList(),
      type: $enumDecode(_$TypeEnumMap, json['type']),
    );

Map<String, dynamic> _$$SelectorImplToJson(_$SelectorImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'now': instance.now,
      'all': instance.all,
      'type': _$TypeEnumMap[instance.type]!,
    };

const _$TypeEnumMap = {
  Type.Pass: 'Pass',
  Type.Reject: 'Reject',
  Type.RejectDrop: 'RejectDrop',
  Type.Selector: 'Selector',
  Type.URLTest: 'URLTest',
  Type.Direct: 'Direct',
  Type.Compatible: 'Compatible',
  Type.Vless: 'Vless',
  Type.Hysteria2: 'Hysteria2',
  Type.Vmess: 'Vmess',
  Type.ShadowsocksR: 'ShadowsocksR',
  Type.Shadowsocks: 'Shadowsocks',
};
