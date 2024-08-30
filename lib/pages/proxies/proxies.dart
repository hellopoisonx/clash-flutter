import 'package:clash_flutter/exception/exception.dart';
import 'package:clash_flutter/models/configs/proxy_mode.dart';
import 'package:clash_flutter/providers/configs/configs.dart';
import 'package:clash_flutter/providers/core/core_status.dart';
import 'package:clash_flutter/providers/proxies/proxies.dart';
import 'package:clash_flutter/widgets/delay_button.dart';
import 'package:clash_flutter/widgets/node_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProxiesPage extends ConsumerWidget {
  const ProxiesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final proxies = ref.watch(proxiesProvider);
    final mode = ref.watch(
        configsProvider.select((value) => value.value?.mode ?? ProxyMode.rule));
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          actions: [
            ToggleButtons(
                isSelected: ProxyMode.values.map((m) => mode == m).toList(),
                onPressed: (idx) => ref
                    .read(configsProvider.notifier)
                    .patchConfigs((conf) => conf.mode = ProxyMode.values[idx]),
                children:
                    ProxyMode.values.map((mode) => Text(mode.name)).toList())
          ],
        ),
        body: proxies.when(
          data: (proxies) => ListView.builder(
            itemCount: proxies.selectors.length,
            itemBuilder: (BuildContext context, int index) {
              final selector = proxies.selectors.values.toList()[index];
              return Container(
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Theme.of(context).colorScheme.primaryContainer,
                ),
                child: ExpansionTile(
                  title: Text(selector.name),
                  subtitle: Text(selector.now),
                  trailing: DelayButton(
                    delayTest: () async {
                      await ref
                          .read(proxiesProvider.notifier)
                          .testSelectorDelay(selector);
                      return await ref
                          .read(proxiesProvider.notifier)
                          .testSingleDelay(selector.name);
                    },
                    initialDelay: selector.history.last.delay,
                  ),
                  children: [
                    GridView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(5),
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 220,
                        mainAxisExtent: 70,
                        crossAxisSpacing: 7,
                        mainAxisSpacing: 11,
                      ),
                      itemCount: selector.all.length,
                      itemBuilder: (context, index) {
                        final node = proxies.all[selector.all[index]]!;
                        return NodeCard(
                          node: node,
                          selected: node.name == selector.now,
                          onTap: () => ref
                              .read(proxiesProvider.notifier)
                              .changeProxyInGroup(selector.name, node.name),
                          delayTest: () async => await ref
                              .read(proxiesProvider.notifier)
                              .testSingleDelay(node.name),
                        );
                      },
                    )
                  ],
                ),
              );
            },
          ),
          error: (e, s) {
            MyException(
                error: e,
                recover: () => ref.invalidate(coreStatusProvider)).show();
            return const Placeholder();
          },
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
        ));
  }
}
