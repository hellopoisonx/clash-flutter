import 'package:clash_flutter/models/settings/settings.dart';
import 'package:clash_flutter/models/proxies/proxies.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

class Apis {
  Apis._();
  static final Apis _instance = Apis._();
  static late Dio _http;
  static late String _ws;
  static const _timeout = Duration(milliseconds: 2500);

  Future<void> init() async {
    final box = Hive.box(name: "clash_flutter");
    final Settings settings = box.get("settings");
    _http = Dio(BaseOptions(
      baseUrl:
          "http://${settings.externalControllerBaseAddress}:${settings.externalControllerPort}",
      connectTimeout: _timeout,
      sendTimeout: _timeout,
      receiveTimeout: _timeout,
    ));
    _ws =
        "ws://${settings.externalControllerBaseAddress}:${settings.externalControllerPort}";
  }

  Future<int?> testSingleDelay(String target) async {
    try {
      final delay = (await _http.get<Map<String, dynamic>>(
              "/proxies/$target/delay",
              queryParameters: {
            "url": Settings.settings.delayTestURL,
            "timeout": Settings.settings.delayTiemout,
          }))
          .data?["delay"] as int?;
      return delay;
    } catch (e) {
      return null;
    }
  }

  Future<Map<String, int?>> testSelectorDelay(String target) async {
    try {
      final resp = await _http.get<Map<String, dynamic>>("/group/$target/delay",
          queryParameters: {
            "url": Settings.settings.delayTestURL,
            "timeout": Settings.settings.delayTiemout,
          },
          options: Options(receiveTimeout: const Duration(seconds: 10)));

      final json = resp.data!;
      return json.map((node, delay) => MapEntry(node, delay as int));
    } catch (e) {
      return {};
    }
  }

  Future<void> changeProxyInGroup(String group, String proxy) async {
    await _http.put("/proxies/$group", data: {"name": proxy});
  }

  Future<Proxies> getProxies() async =>
      Proxies.fromJson((await _http.get("/proxies")).data);
}

final apis = Apis._instance;
