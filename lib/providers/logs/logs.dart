import 'package:clash_core/clash_core.dart';
import 'package:clash_flutter/apis/apis.dart';
import 'package:clash_flutter/models/log/log.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'logs.g.dart';

@riverpod
Stream<List<String>> stdout(StdoutRef ref) async* {
  List<String> logs = [];
  await for (var log in clashCore.stdout ?? const Stream<String>.empty()) {
    if (logs.length > 500) logs.clear();
    logs.insert(0, log);
    yield logs;
  }
}

@riverpod
Stream<List<Log>> logFromApi(LogFromApiRef ref) async* {
  final stream = apis.getLogs();
  final List<Log> logs = [];
  await for (var log in stream) {
    if (logs.length > 500) logs.clear();
    logs.insert(0, log);
    yield logs;
  }
}
