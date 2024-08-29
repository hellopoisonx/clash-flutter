import 'package:clash_flutter/models/proxies/node.dart';
import 'package:clash_flutter/models/proxies/selector.dart';
import 'package:clash_flutter/models/proxies/type.dart';
import 'package:clash_flutter/providers/core/core_status.dart';
import 'package:clash_flutter/providers/proxies/proxies.dart';
import 'package:clash_flutter/widgets/delay_button.dart';
import 'package:clash_flutter/widgets/status_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProxiesPage extends ConsumerWidget {
  const ProxiesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final proxies = ref.watch(proxiesProvider);
    return Scaffold(
        floatingActionButton: FloatingActionButton.small(
          onPressed: () => ref.invalidate(proxiesProvider),
          child: const Icon(Icons.refresh_rounded),
        ),
        body: proxies.when(
          data: (proxies) => ListView.builder(
            itemCount: proxies.selectors.length,
            itemBuilder: (BuildContext context, int index) {
              final selector = proxies.selectors.values.toList()[index];
              return Container(
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromRGBO(242, 242, 242, 1),
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
                    initialDelay: proxies.delays[selector.name],
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
                        return Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            boxShadow: [
                              node.name == selector.now
                                  ? const BoxShadow(
                                      blurRadius: 5, color: Colors.orange)
                                  : const BoxShadow(blurRadius: 2)
                            ],
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: InkWell(
                            onTap: () => ref
                                .read(proxiesProvider.notifier)
                                .changeProxyInGroup(selector.name, node.name),
                            borderRadius: BorderRadius.circular(10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                          child: Text(
                                        node.name,
                                        overflow: TextOverflow.ellipsis,
                                      )),
                                      Row(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                  color: Colors.grey, width: 2),
                                            ),
                                            padding: const EdgeInsets.all(1),
                                            margin:
                                                const EdgeInsets.only(right: 3),
                                            child: Text(
                                              node.type.name,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelSmall,
                                            ),
                                          ),
                                          if (node.type == Type.Selector ||
                                              node.type == Type.URLTest)
                                            Expanded(
                                              child: Text(
                                                (node as Selector).now,
                                                overflow: TextOverflow.ellipsis,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelSmall,
                                              ),
                                            ),
                                          if (node.type != Type.Selector &&
                                              node.type != Type.URLTest)
                                            Expanded(
                                              child: StatusIndicator(
                                                status: (node as Node).udp,
                                                prefix: "udp",
                                                size: 5,
                                              ),
                                            ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                    width: 50,
                                    alignment: Alignment.centerRight,
                                    child: DelayButton(
                                      delayTest: () async => await ref
                                          .read(proxiesProvider.notifier)
                                          .testSingleDelay(node.name),
                                      initialDelay: proxies.delays[node.name],
                                    ))
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              );
            },
          ),
          error: (e, s) {
            ref.invalidate(coreStatusProvider);
            return null;
          },
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
        ));
  }
}
