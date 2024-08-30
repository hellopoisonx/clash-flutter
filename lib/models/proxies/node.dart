import 'package:clash_flutter/models/proxies/history.dart';
import 'package:clash_flutter/models/proxies/selectable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:clash_flutter/models/proxies/type.dart';
import 'package:flutter/foundation.dart';

part 'node.freezed.dart';
part 'node.g.dart';

@Freezed(copyWith: true)
class Node with _$Node, Selectable {
  const factory Node({
    required String name,
    required List<History> history,
    required Type type,
    required bool udp,
  }) = _Node;
  factory Node.fromJson(Map<String, dynamic> json) => _$NodeFromJson(json);
}
