import 'package:clash_flutter/exception/exception.dart';
import 'package:clash_flutter/providers/configs/configs.dart';
import 'package:clash_flutter/models/configs/configs.dart';
import 'package:clash_flutter/providers/core/core_status.dart';
import 'package:flutter/material.dart' hide Stack;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConfigsPage extends ConsumerWidget {
  const ConfigsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final configs = ref.watch(configsProvider);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: configs.when(
          error: (e, s) {
            MyException.show(
                error: e, recover: () => ref.invalidate(coreStatusProvider));
            return null;
          },
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          data: (configs) {
            return ListView(
              children: [
                ExpansionTile(
                  title: const Text("Tun"),
                  children: [
                    SwitchListTile(
                      title: const Text("Enable"),
                      value: configs.tun?.enable ?? false,
                      onChanged: (val) => ref
                          .read(configsProvider.notifier)
                          .patchConfigs((conf) => conf.tun!.enable = val),
                    ),
                    SwitchListTile(
                      title: const Text("AutoRoute"),
                      value: configs.tun?.autoRoute ?? false,
                      onChanged: (val) => ref
                          .read(configsProvider.notifier)
                          .patchConfigs((conf) => conf.tun!.autoRoute = val),
                    ),
                    SwitchListTile(
                      title: const Text("AutoDetectInterface"),
                      value: configs.tun?.autoDetectInterface ?? false,
                      onChanged: (val) => ref
                          .read(configsProvider.notifier)
                          .patchConfigs(
                              (conf) => conf.tun!.autoDetectInterface = val),
                    ),
                    ListTile(
                      title: const Text("Stack"),
                      trailing: SegmentedButton(
                        segments: Stack.values
                            .map((stack) => ButtonSegment(
                                value: stack, label: Text(stack.name)))
                            .toList(),
                        selected: <Stack>{configs.tun?.stack ?? Stack.mixed},
                        onSelectionChanged: (val) => ref
                            .read(configsProvider.notifier)
                            .patchConfigs(
                                (conf) => conf.tun!.stack = val.first),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: "device",
                          hintText: configs.tun?.device,
                        ),
                        onSubmitted: (val) => ref
                            .read(configsProvider.notifier)
                            .patchConfigs((conf) => conf.tun!.device = val),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: "dns-hijack",
                          hintText: configs.tun?.dnsHijack?.join(" "),
                        ),
                        onSubmitted: (val) => ref
                            .read(configsProvider.notifier)
                            .patchConfigs(
                                (conf) => conf.tun!.dnsHijack = val.split(" ")),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
