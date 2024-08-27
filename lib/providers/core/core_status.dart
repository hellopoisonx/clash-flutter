import 'package:clash_core/clash_core.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'core_status.g.dart';

@riverpod
Stream<CoreStatus> coreStatus(CoreStatusRef ref) async* {
  ref.onDispose(() async => await clashCore.status.close());
  await for (var status in clashCore.status.stream) {
    yield status;
  }
}
