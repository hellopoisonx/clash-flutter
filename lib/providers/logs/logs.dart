import 'package:clash_core/clash_core.dart';
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
