import 'package:clash_flutter/apis/apis.dart';
import 'package:fuzzy/fuzzy.dart';
import 'package:clash_flutter/models/rule/rule.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'rules.g.dart';

@riverpod
Future<List<Rule>> rules(RulesRef ref) async {
  final alive = ref.keepAlive();
  ref.onDispose(alive.close);
  return await apis.getRules();
}

@riverpod
Future<List<Rule>> filteredRules(FilteredRulesRef ref, String query) async {
  final rules = await ref.watch(rulesProvider.future);
  if (query.trim().isEmpty) {
    return rules;
  }
  return Fuzzy(rules,
      options: FuzzyOptions(
        shouldSort: true,
        isCaseSensitive: false,
        keys: [
          WeightedKey(
            name: "payload",
            getter: (Rule rule) => rule.payload,
            weight: 1,
          ),
          WeightedKey(
            name: "proxy",
            getter: (Rule rule) => rule.proxy,
            weight: 1,
          ),
          WeightedKey(
            name: "type",
            getter: (Rule rule) => rule.type,
            weight: 1,
          ),
        ],
      )).search(query).map((result) => result.item).toList();
}
