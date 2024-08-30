import 'package:clash_core/clash_core.dart';
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
            MyException(
                error: e,
                recover: () => ref.invalidate(coreStatusProvider)).show();
            return null;
          },
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          data: (configs) {
            return ListView(
              children: [
                SwitchListTile(
                  title: const Text("Tun"),
                  value: configs.tun?.enable ?? false,
                  onChanged: (val) => ref
                      .read(configsProvider.notifier)
                      .patchConfigs((conf) => conf.tun!.enable = val),
                ),
                SwitchListTile(
                  title: const Text("AutoRoute"),
                  value: configs.tun?.autoRoute ?? false,
                  onChanged: (configs.tun?.enable ?? false)
                      ? (val) => ref
                          .read(configsProvider.notifier)
                          .patchConfigs((conf) => conf.tun!.autoRoute = val)
                      : null,
                ),
                SwitchListTile(
                  title: const Text("AutoDetectInterface"),
                  value: configs.tun?.autoDetectInterface ?? false,
                  onChanged: (configs.tun?.enable ?? false)
                      ? (val) => ref
                          .read(configsProvider.notifier)
                          .patchConfigs(
                              (conf) => conf.tun!.autoDetectInterface = val)
                      : null,
                ),
                ListTile(
                  enabled: configs.tun?.enable ?? false,
                  title: const Text("Stack"),
                  trailing: SegmentedButton(
                    showSelectedIcon: false,
                    segments: Stack.values
                        .map((stack) => ButtonSegment(
                            enabled: configs.tun?.enable ?? false,
                            value: stack,
                            label: Text(stack.name)))
                        .toList(),
                    selected: <Stack>{configs.tun?.stack ?? Stack.mixed},
                    onSelectionChanged: (val) => ref
                        .read(configsProvider.notifier)
                        .patchConfigs((conf) => conf.tun!.stack = val.first),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    enabled: configs.tun?.enable ?? false,
                    decoration: InputDecoration(
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
                    enabled: configs.tun?.enable ?? false,
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
                ListTile(
                  title: const Text("GeoDatabase"),
                  trailing: TextButton(
                    onPressed: () async {
                      try {
                        await clashCore.updateGeoDatabase();
                      } catch (e) {
                        await MyException(error: e).show();
                      }
                    },
                    child: const Text("Upgrade"),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
