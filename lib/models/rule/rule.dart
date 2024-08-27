import 'package:freezed_annotation/freezed_annotation.dart';

part 'rule.g.dart';
part 'rule.freezed.dart';

@freezed
class Rule with _$Rule {
 const factory Rule({
    required String type,
    required String payload,
    required String proxy,
  }) = _Rule; 

  factory Rule.fromJson(Map<String, dynamic> json) => _$RuleFromJson(json);
}
