import 'package:clash_flutter/exception/exception.dart';
import 'package:clash_flutter/providers/core/core_status.dart';
import 'package:clash_flutter/providers/logs/logs.dart';
import 'package:clash_flutter/models/log/log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LogsPage extends ConsumerStatefulWidget {
  const LogsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LogsPageState();
}

class _LogsPageState extends ConsumerState<LogsPage> {
  String query = "";
  Type type = Type.all;

  @override
  Widget build(BuildContext context) {
    final logs = ref.watch(filteredLogsProvider(query, type));
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(61),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: "Search among ${logs.value?.length ?? 0} logs"),
                  onChanged: (value) => setState(() => query = value.trim()),
                ),
              ),
              const SizedBox(width: 5),
              ToggleButtons(
                isSelected: Type.values.map((t) => t == type).toList(),
                onPressed: (idx) => setState(() => type = Type.values[idx]),
                children: Type.values.map<Text>((t) => Text(t.name)).toList(),
              ),
            ],
          ),
        ),
      ),
      body: logs.when(
          data: (logs) => ListView.builder(
                itemCount: logs.length,
                itemBuilder: (context, idx) {
                  return Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context).colorScheme.primaryContainer,
                    ),
                    child: () {
                      final log = logs[idx];
                      return ListTile(
                        leading: Text((logs.length - idx).toString()),
                        title: Text(log.payload),
                        subtitle: Text(
                          log.type.field,
                          style:
                              Theme.of(context).textTheme.labelMedium?.copyWith(
                                  color: log.type == Type.info
                                      ? Colors.green
                                      : log.type == Type.err
                                          ? Colors.red
                                          : Colors.orange),
                        ),
                      );
                    }(),
                  );
                },
              ),
          error: (e, s) {
            MyException(
                error: e,
                recover: () => ref.invalidate(coreStatusProvider)).show();
            return null;
          },
          loading: () => const Center(
                child: CircularProgressIndicator(),
              )),
    );
  }
}
