import 'dart:async';

import 'package:clash_flutter/models/configs/proxy_mode.dart';
import 'package:clash_flutter/models/proxies/selector.dart';
import 'package:clash_flutter/models/proxies/type.dart';
import 'package:clash_flutter/providers/commons/commons.dart';
import 'package:clash_flutter/providers/configs/configs.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:clash_flutter/models/proxies/proxies.dart' as p;

part 'proxies.g.dart';

@riverpod
class Proxies extends _$Proxies {
  @override
  Future<p.Proxies> build() async {
    final apis = await ref.getApis();
    final mode = await ref.watch(
        configsProvider.selectAsync((conf) => conf.mode ?? ProxyMode.rule));
    final proxies = await apis.getProxies();
    return switch (mode) {
      ProxyMode.global =>
        proxies.copyWith(selectors: {"GLOBAL": proxies.selectors["GLOBAL"]!}),
      ProxyMode.rule =>
        proxies.copyWith(selectors: {...proxies.selectors}..remove("GLOBAL")),
      ProxyMode.direct => proxies.copyWith(
          selectors: {
            "DIRECT": Selector(
              name: "DIRECT",
              now: 'DIRECT',
              all: ["DIRECT"],
              history: proxies.all["DIRECT"]!.history,
              type: Type.Selector,
            )
          },
          all: {"DIRECT": proxies.all["DIRECT"]!},
        ),
    };
  }

  Future<int?> testSingleDelay(String target) async {
    final apis = await ref.getApis(false);
    final delay = await apis.testSingleDelay(target);
    ref.invalidateSelf();
    return delay;
  }

  Future<Map<String, int?>> testSelectorDelay(Selector target) async {
    final apis = await ref.getApis(false);
    final Map<String, int?> delays = await apis.testSelectorDelay(target.name);
    for (var node in target.all) {
      delays.addAll({node: delays[node]});
    }
    ref.invalidateSelf();
    return delays;
  }

  void changeProxyInGroup(String group, String proxy) async {
    final apis = await ref.getApis();
    await apis.changeProxyInGroup(group, proxy);
    ref.invalidateSelf();
  }
}
