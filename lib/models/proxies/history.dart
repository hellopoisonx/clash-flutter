import 'package:freezed_annotation/freezed_annotation.dart';

part 'history.g.dart';
part 'history.freezed.dart';

@freezed
class History with _$History {
  const factory History(
      {required DateTime time,
      @JsonKey(fromJson: _delayFromJson) int? delay}) = _History;

  factory History.fromJson(Map<String, dynamic> json) =>
      _$HistoryFromJson(json);
}

int? _delayFromJson(int delay) => delay == 0 ? null : delay;
