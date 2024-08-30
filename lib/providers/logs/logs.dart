import 'package:clash_flutter/models/log/log.dart';
import 'package:fuzzy/fuzzy.dart';
import 'package:clash_flutter/providers/commons/commons.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'logs.g.dart';

@riverpod
Stream<List<Log>> logs(LogsRef ref) async* {
  final apis = await ref.getApis();
  ref.keepAlive();
  final stream = apis.getLogs();
  final List<Log> logs = [];
  await for (var log in stream) {
    if (logs.length > 500) logs.clear();
    logs.insert(0, log);
    yield logs;
  }
}

@riverpod
Future<List<Log>> filteredLogs(
    FilteredLogsRef ref, String query, Type type) async {
  final allLogs = await ref.watch(logsProvider.future);
  List<Log> logs = [];
  if (type == Type.all) {
    logs = allLogs;
  } else {
    logs = allLogs.where((log) => log.type == type).toList();
  }
  if (query.trim().isEmpty) {
    return logs;
  }
  return Fuzzy(logs,
      options: FuzzyOptions(
        shouldSort: true,
        keys: [
          WeightedKey(
              name: "payload", getter: (Log log) => log.payload, weight: 1)
        ],
      )).search(query).map<Log>((result) => result.item).toList();
}
