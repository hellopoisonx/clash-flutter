import 'package:clash_flutter/exception/exception.dart';
import 'package:clash_flutter/models/rule/rule.dart';
import 'package:clash_flutter/providers/core/core_status.dart';
import 'package:clash_flutter/providers/rules/rules.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RulesPage extends ConsumerStatefulWidget {
  const RulesPage({super.key});

  @override
  ConsumerState<RulesPage> createState() => _RulesPageState();
}

class _RulesPageState extends ConsumerState<RulesPage> {
  String query = "";
  @override
  Widget build(BuildContext context) {
    final rules = ref.watch(filteredRulesProvider(query));
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(61),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              hintText:
                  "Search among ${ref.read(rulesProvider).value?.length ?? 0} rules",
            ),
            onChanged: (value) => value.trim() != query.trim()
                ? setState(
                    () => query = value.trim(),
                  )
                : () => (),
          ),
        ),
      ),
      body: rules.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) {
          MyException(
              error: error,
              recover: () => ref.invalidate(coreStatusProvider)).show();
          return null;
        },
        data: (List<Rule>? value) => ListView.builder(
            itemCount: value?.length ?? 0,
            prototypeItem: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
              child: const ListTile(
                title: Text("prototypeItem"),
                subtitle: Text("prototypeItem"),
              ),
            ),
            itemBuilder: (context, idx) {
              final rule = value![idx];
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Theme.of(context).colorScheme.primaryContainer,
                ),
                child: ListTile(
                  title: Text(rule.payload),
                  subtitle: Text("${rule.type}::${rule.proxy}"),
                ),
              );
            }),
      ),
    );
  }
}
