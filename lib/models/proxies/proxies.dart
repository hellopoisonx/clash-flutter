import 'package:clash_flutter/models/proxies/node.dart';
import 'package:clash_flutter/models/proxies/selectable.dart';
import 'package:clash_flutter/models/proxies/selector.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

export 'package:clash_flutter/models/proxies/type.dart';

part 'proxies.freezed.dart';

@Freezed(equal: true, toJson: false, fromJson: false, copyWith: true)
class Proxies with _$Proxies {
  const Proxies._();
  const factory Proxies(
      {required final Map<String, Selector> selectors,
      required final Map<String, Selectable> all,
      required final Map<String, int?> delays}) = _Proxies;

  factory Proxies.fromJson(Map<String, dynamic> json) {
    _e(!json.containsKey("proxies"));
    final Map<String, Selector> selectors = {};
    final Map<String, Selectable> all = {};
    json = json["proxies"];
    for (final entry in json.entries) {
      final k = entry.key;
      final v = Map<String, dynamic>.from(entry.value);
      _e(!v.containsKey("type"));
      if (v["type"] == "Selector" || v["type"] == "URLTest") {
        final s = Selector.fromJson(v);
        selectors.addAll({k: s});
        all.addAll({k: s});
      } else {
        all.addAll({k: Node.fromJson(v)});
      }
    }
    return Proxies(selectors: selectors, all: all, delays: {});
  }

  static void _e(bool f) {
    if (f) {
      throw Exception("Error analyzing proxies json data");
    }
  }
}
