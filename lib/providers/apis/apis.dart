import 'dart:convert';
import 'dart:io';

import 'package:clash_flutter/exception/exception.dart';
import 'package:clash_flutter/models/configs/configs.dart';
import 'package:clash_flutter/models/log/log.dart';
import 'package:clash_flutter/models/profiles/profile.dart';
import 'package:clash_flutter/models/rule/rule.dart';
import 'package:clash_flutter/models/connections/connections.dart';
import 'package:clash_flutter/models/settings/settings.dart';
import 'package:clash_flutter/providers/core/core_status.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:traffic/traffic.dart';
import 'package:path/path.dart' as p;
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:clash_flutter/models/proxies/proxies.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

part 'apis.g.dart';

class Apis {
  late Dio _http;
  late String _ws;
  static const _timeout = Duration(milliseconds: 2500);

  Apis(bool needInterceptor) {
    final box =
        Hive.box(name: "clash_flutter", directory: Hive.defaultDirectory);
    final Settings settings = box.get("settings");
    if (needInterceptor) {
      _http = Dio(BaseOptions(
        baseUrl:
            "http://${settings.externalControllerBaseAddress}:${settings.externalControllerPort}",
        connectTimeout: _timeout,
        sendTimeout: _timeout,
        receiveTimeout: _timeout,
      ))
        ..interceptors.add(InterceptorsWrapper(onError: (e, h) {
          MyException(error: e).show();
          h.next(e);
        }));
    } else {
      _http = Dio(BaseOptions(
        baseUrl:
            "http://${settings.externalControllerBaseAddress}:${settings.externalControllerPort}",
        connectTimeout: _timeout,
        sendTimeout: _timeout,
        receiveTimeout: _timeout,
      ));
    }
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

  Future<Map<String, int?>> testSelectorDelay(String target,
      [bool needInterceptor = true]) async {
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

  // (up, down)
  Stream<(Traffic, Traffic)> getTraffics() async* {
    final chan = WebSocketChannel.connect(Uri.parse("$_ws/traffic"));
    await chan.ready;
    await for (String rawJson in chan.stream) {
      final Map<String, dynamic> json = jsonDecode(rawJson);
      final up = (json["up"] as int);
      final down = (json["down"] as int);
      yield (Traffic.fromByte(byte: up), Traffic.fromByte(byte: down));
    }
  }

  Stream<Traffic> getMemory() async* {
    final chan = WebSocketChannel.connect(Uri.parse("$_ws/memory"));
    await chan.ready;
    await for (String rawJson in chan.stream) {
      final Map<String, dynamic> json = jsonDecode(rawJson);
      yield Traffic.fromByte(byte: json["inuse"] as int);
    }
  }

  Future<List<Rule>> getRules() async {
    final resp = await _http.get("/rules");
    final rules = resp.data!["rules"]!;
    return rules
        .map<Rule>((json) => Rule.fromJson(Map<String, dynamic>.from(json)))
        .toList();
  }

  Stream<Log> getLogs() async* {
    final chan = WebSocketChannel.connect(Uri.parse("$_ws/logs"));
    await chan.ready;
    await for (String rawJson in chan.stream) {
      final Map<String, dynamic> json = jsonDecode(rawJson);
      yield Log.fromJson(json);
    }
  }

  Stream<Connections> getConnections() async* {
    final chan = WebSocketChannel.connect(Uri.parse("$_ws/connections"));
    await chan.ready;
    await for (String rawJson in chan.stream) {
      final Map<String, dynamic> json = jsonDecode(rawJson);
      yield Connections.fromJson(json);
    }
  }

  Future<void> closeALlConnections() async {
    await _http.delete("/connections");
  }

  Future<void> closeSingleConnection(String id) async {
    await _http.delete("/connections/$id");
  }

  Future<bool> isReady() async {
    try {
      return Map<String, dynamic>.from((await _http.get("")).data)
          .containsKey("hello");
    } catch (e) {
      return false;
    }
  }

  Future<Configs> getConfigs() async {
    return Configs.fromJson((await _http.get("/configs")).data);
  }

  Future<void> patchConfigs(Configs conf) async =>
      await _http.patch("/configs", data: conf.toJson());

  Future<Profile> downloadProfile(String url, String savePath) async {
    final resp = await Dio().get(url);
    final headers = resp.headers.map;
    String fileName = DateTime.now().toIso8601String();
    if (headers.containsKey("content-disposition")) {
      List<String> dis = headers["content-disposition"]!;
      for (var field in dis) {
        try {
          field = field.split(";").last;
        } catch (_) {}
        if (field.startsWith("filename")) {
          if (field.startsWith("filename*")) {
            try {
              fileName = field.split("'").last;
            } catch (_) {
              break;
            }
          } else {
            try {
              fileName = field.split("=").last;
            } catch (e) {
              break;
            }
          }
        }
      }
    }
    String path = p.join(savePath, "$fileName.yaml");
    if (File(path).existsSync()) {
      fileName = "$fileName-${DateTime.now().toIso8601String()}";
    }
    path = p.join(savePath, "$fileName.yaml");
    await Dio().download(url, path);
    if (headers.containsKey("subscription-userinfo")) {
      final subInfo = headers["subscription-userinfo"]!.join("").split(";");
      Map<String, int> m = {};
      for (var eles in subInfo) {
        final key = eles.split("=").first.trim();
        final value = int.parse(eles.split("=").last);
        m[key] = value;
      }
      return Profile(
          name: fileName,
          path: path,
          createdTime: DateTime.now(),
          url: url,
          totalTraffic:
              m["total"] != null ? Traffic.fromByte(byte: m["total"]!) : null,
          downloadTraffic: m["download"] != null
              ? Traffic.fromByte(byte: m["download"]!)
              : null,
          uploadTraffic:
              m["upload"] != null ? Traffic.fromByte(byte: m["upload"]!) : null,
          expirationTime: m["expire"] != null
              ? DateTime.fromMicrosecondsSinceEpoch(m["expire"]!)
              : null);
    } else {
      return Profile(
        name: fileName,
        path: path,
        createdTime: DateTime.now(),
        url: url,
      );
    }
  }
}

@riverpod
Future<Apis> apis(ApisRef ref, [bool needInterceptor = true]) async {
  ref.watch(coreStatusProvider);
  return Apis(needInterceptor);
}
