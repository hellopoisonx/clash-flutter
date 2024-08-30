// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'node.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NodeImpl _$$NodeImplFromJson(Map<String, dynamic> json) => _$NodeImpl(
      name: json['name'] as String,
      history: (json['history'] as List<dynamic>)
          .map((e) => History.fromJson(e as Map<String, dynamic>))
          .toList(),
      type: $enumDecode(_$TypeEnumMap, json['type']),
      udp: json['udp'] as bool,
    );

Map<String, dynamic> _$$NodeImplToJson(_$NodeImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'history': instance.history,
      'type': _$TypeEnumMap[instance.type]!,
      'udp': instance.udp,
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
