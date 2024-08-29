import 'package:clash_flutter/providers/commons/commons.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:traffic/traffic.dart';

part 'memory.g.dart';

@riverpod
// (up, down)
Stream<Traffic> memory(MemoryRef ref) async* {
  final apis = await ref.getApis();
  final stream = apis.getMemory();
  await for (final traffic in stream) {
    yield traffic;
  }
}
