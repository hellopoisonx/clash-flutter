import 'dart:async';

import 'package:clash_flutter/apis/apis.dart';
import 'package:clash_flutter/models/proxies/selector.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:clash_flutter/models/proxies/proxies.dart' as p;

part 'proxies.g.dart';

@riverpod
class Proxies extends _$Proxies {
  @override
  Future<p.Proxies> build() async {
    final alive = ref.keepAlive();
    final timer = Timer(const Duration(minutes: 1), alive.close);
    ref.onDispose(timer.cancel);
    return await apis.getProxies();
  }

  Future<int?> testSingleDelay(String target) async {
    final delay = await apis.testSingleDelay(target);
    final prev = await future;
    state =
        AsyncValue.data(prev.copyWith(delays: {...prev.delays, target: delay}));
    return delay;
  }

  Future<Map<String, int?>> testSelectorDelay(Selector target) async {
    final Map<String, int?> delays = await apis.testSelectorDelay(target.name);
    for (var node in target.all) {
      delays.addAll({node: delays[node]});
    }
    var prev = await future;
    state = AsyncValue.data(prev.copyWith(delays: {...prev.delays, ...delays}));
    return delays;
  }

  void changeProxyInGroup(String group, String proxy) async {
    await apis.changeProxyInGroup(group, proxy);
    final prev = await future;
    state = AsyncValue.data(prev.copyWith(selectors: {
      ...prev.selectors,
      group: prev.selectors[group]!.copyWith(now: proxy)
    }));
  }

  void refresh() => ref.invalidateSelf();
}
