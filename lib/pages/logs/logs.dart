import 'package:clash_flutter/providers/logs/logs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LogsPage extends ConsumerWidget {
  const LogsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logs = ref.watch(stdoutProvider);
    return Scaffold(
      body: logs.when(
          data: (logs) => ListView.builder(
                itemCount: logs.length,
                itemBuilder: (context, idx) {
                  return ListTile(
                    leading: Text((idx + 1).toString()),
                    title: Text(logs[idx]),
                  );
                },
              ),
          error: (e, s) => Center(
                child: Text(e.toString()),
              ),
          loading: () => const Center(
                child: CircularProgressIndicator(),
              )),
    );
  }
}
