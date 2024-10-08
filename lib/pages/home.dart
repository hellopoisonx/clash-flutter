import 'package:clash_core/clash_core.dart';
import 'package:clash_flutter/exception/exception.dart';
import 'package:clash_flutter/pages/configs/configs.dart';
import 'package:clash_flutter/pages/connections/connections.dart';
import 'package:clash_flutter/pages/logs/logs.dart';
import 'package:clash_flutter/pages/profiles/profiles.dart';
import 'package:clash_flutter/pages/proxies/proxies.dart';
import 'package:clash_flutter/pages/rules/rules.dart';
import 'package:clash_flutter/providers/core/core_status.dart';
import 'package:clash_flutter/providers/memory/memory.dart';
import 'package:clash_flutter/providers/themes/theme_mode.dart';
import 'package:clash_flutter/providers/traffics/traffics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_manager/window_manager.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> with WindowListener {
  @override
  void initState() {
    super.initState();
    windowManager.addListener(this);
    _init();
  }

  void _init() async {
    await windowManager.setPreventClose(true);
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    windowManager.removeListener(this);
  }

  @override
  void onWindowClose() async {
    super.onWindowClose();
    clashCore.shutdown();
    await windowManager.destroy();
  }

  final List<(IconData, String, Widget)> _pages = const [
    (Icons.router_rounded, "Proxies", ProxiesPage()),
    (Icons.bug_report_rounded, "Logs", LogsPage()),
    (Icons.person_rounded, "Profiles", ProfilesPage()),
    (Icons.rule_rounded, "Rules", RulesPage()),
    (Icons.computer_rounded, "Connections", ConnectionsPage()),
    (Icons.settings_rounded, "Settings", ConfigsPage()),
  ];
  int pageIdx = 0;
  @override
  Widget build(BuildContext context) {
    final traffics = ref.watch(trafficsProvider);
    final memory = ref.watch(memoryProvider);
    final themeMode = ref.watch(themeModeNotifierProvider);
    return Row(
      children: [
        NavigationRail(
          minExtendedWidth: 150,
          labelType: NavigationRailLabelType.none,
          groupAlignment: 0,
          extended: true,
          destinations: _pages
              .map(
                (page) => NavigationRailDestination(
                  icon: Icon(page.$1),
                  label: Text(page.$2),
                ),
              )
              .toList(),
          selectedIndex: pageIdx,
          onDestinationSelected: (idx) => setState(() => pageIdx = idx),
          leading: SizedBox(
            width: 150,
            height: 160,
            child: Column(
              children: [
                SizedBox(
                  height: 100,
                  child: traffics.when(
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                      error: (e, s) {
                        MyException(
                            error: e,
                            recover: () =>
                                ref.invalidate(coreStatusProvider)).show();
                        return null;
                      },
                      data: (traffics) {
                        final style = Theme.of(context).textTheme.labelLarge;
                        return Column(
                          children: [
                            Expanded(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Up:", style: style),
                                  Text("${traffics.$1}/s", style: style),
                                ],
                              ),
                            )),
                            Expanded(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Down:", style: style),
                                  Text("${traffics.$2}/s", style: style),
                                ],
                              ),
                            )),
                          ],
                        );
                      }),
                ),
                Expanded(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: memory.when(
                          data: (memory) {
                            final style =
                                Theme.of(context).textTheme.labelLarge;
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Mem:", style: style),
                                Text(memory.toString(), style: style),
                              ],
                            );
                          },
                          error: (e, s) {
                            MyException(
                                error: e,
                                recover: () =>
                                    ref.invalidate(coreStatusProvider)).show();
                            return null;
                          },
                          loading: () =>
                              const Center(child: CircularProgressIndicator()),
                        )))
              ],
            ),
          ),
          trailing: ToggleButtons(
            isSelected: ThemeMode.values
                .toList()
                .map((mode) => mode == themeMode)
                .toList(),
            onPressed: (idx) => ref
                .read(themeModeNotifierProvider.notifier)
                .mode = ThemeMode.values[idx],
            children: ThemeMode.values
                .map((mode) => Icon(switch (mode) {
                      ThemeMode.system => Icons.auto_mode_rounded,
                      ThemeMode.light => Icons.light_mode_rounded,
                      ThemeMode.dark => Icons.dark_mode_rounded,
                    }))
                .toList(),
          ),
        ),
        Expanded(child: _pages[pageIdx].$3)
      ],
    );
  }
}
