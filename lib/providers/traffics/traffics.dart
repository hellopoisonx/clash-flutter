import 'package:clash_flutter/apis/apis.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:traffic/traffic.dart';

part 'traffics.g.dart';

@riverpod
// (up, down)
Stream<(Traffic, Traffic)> traffics(TrafficsRef ref) async* {
  final stream = apis.getTraffics();
  await for (final traffics in stream) {
    yield traffics;
  }
}
