import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:clash_flutter/models/log/type.dart';

export 'package:clash_flutter/models/log/type.dart';

part 'log.g.dart';
part 'log.freezed.dart';

@freezed
class Log with _$Log {
  const factory Log({required Type type, required String payload}) = _Log;

  factory Log.fromJson(Map<String, dynamic> json) => _$LogFromJson(json);
}
