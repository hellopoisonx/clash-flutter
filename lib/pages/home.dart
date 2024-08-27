import 'package:clash_core/clash_core.dart';
import 'package:clash_flutter/pages/logs/logs.dart';
import 'package:clash_flutter/pages/profiles/profiles.dart';
import 'package:clash_flutter/pages/proxies/proxies.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WindowListener {
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
    await clashCore.shutdown();
    await windowManager.destroy();
  }

  final List<(IconData, String, Widget)> _pages = const [
    (Icons.grid_3x3_rounded, "Overview", Placeholder()),
    (Icons.router_rounded, "Proxies", ProxiesPage()),
    (Icons.bug_report_rounded, "Logs", LogsPage()),
    (Icons.person_rounded, "Profiles", ProfilesPage()),
  ];
  int pageIdx = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        NavigationRail(
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
        ),
        Expanded(child: _pages[pageIdx].$3)
      ],
    );
  }
}
