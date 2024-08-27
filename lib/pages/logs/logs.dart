import 'package:clash_flutter/models/log/log.dart';
import 'package:clash_flutter/providers/logs/logs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LogsPage extends ConsumerStatefulWidget {
  const LogsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LogsPageState();
}

class _LogsPageState extends ConsumerState<LogsPage> {
  bool isApi = true;

  @override
  Widget build(BuildContext context) {
    final logs =
        isApi ? ref.watch(logFromApiProvider) : ref.watch(stdoutProvider);
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              //color: Colors.grey.withOpacity(0.3),
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(10),
              child: ToggleButtons(
                fillColor: Colors.transparent,
                borderRadius: BorderRadius.circular(10),
                isSelected: [isApi, !isApi],
                children: const ["Api", "Stdout"]
                    .map((text) => Container(
                          height: 60,
                          width: 60,
                          margin: const EdgeInsets.all(2),
                          child: Center(
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              height: 30,
                              width: 50,
                              decoration: BoxDecoration(
                                  color: isApi
                                      ? text == "Api"
                                          ? const Color.fromRGBO(
                                              232, 222, 248, 1)
                                          : Colors.transparent
                                      : text != "Api"
                                          ? const Color.fromRGBO(
                                              232, 222, 248, 1)
                                          : Colors.transparent,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(child: Text(text)),
                            ),
                          ),
                        ))
                    .toList(),
                onPressed: (idx) => setState(() => isApi = idx == 0),
              ),
            ),
          )
        ],
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
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromRGBO(242, 242, 242, 1),
                    ),
                    child: () {
                      if (!isApi) {
                        final log = logs[idx] as String;
                        return ListTile(
                          leading: Text((logs.length - idx).toString()),
                          title: Text(log),
                        );
                      } else {
                        final log = logs[idx] as Log;
                        return ListTile(
                          leading: Text((logs.length - idx).toString()),
                          title: Text(log.payload),
                          subtitle: Text(log.type.field),
                        );
                      }
                    }(),
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
