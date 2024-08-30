import 'package:clash_flutter/models/proxies/history.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:clash_flutter/models/proxies/selectable.dart';
import 'package:clash_flutter/models/proxies/type.dart';
import 'package:flutter/foundation.dart';

part 'selector.freezed.dart';
part 'selector.g.dart';

@Freezed(copyWith: true)
class Selector with _$Selector, Selectable {
  const factory Selector({
    required String name,
    required String now,
    required List<String> all,
    required List<History> history,
    required Type type,
  }) = _Selector;
  factory Selector.fromJson(Map<String, dynamic> json) =>
      _$SelectorFromJson(json);
}
