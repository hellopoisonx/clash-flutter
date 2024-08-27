import 'dart:io';

import 'package:clash_flutter/apis/apis.dart';
import 'package:clash_flutter/constants/constants.dart';
import 'package:clash_flutter/models/profiles/profiles.dart';
import 'package:clash_flutter/models/settings/settings.dart';
import 'package:clash_flutter/pages/home.dart';
import 'package:clash_core/clash_core.dart';
import 'package:clash_flutter/providers/core/core_status.dart';
import 'package:clash_flutter/providers/logs/logs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:window_manager/window_manager.dart';
import 'package:hive/hive.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  WindowOptions winOpts = const WindowOptions(
    title: "Clash-Flutter",
    size: Size(800, 800),
    backgroundColor: Colors.white,
    titleBarStyle: TitleBarStyle.normal,
  );
  windowManager.waitUntilReadyToShow(winOpts, () async {
    Constants.hivePath = (await getApplicationSupportDirectory()).path;
    await Directory(Constants.hivePath).create();
    Hive.defaultDirectory = Constants.hivePath;
    Constants.defaultHomeDir = Constants.hivePath;
    Constants.defaultProfilePath = p.join(
        Constants.defaultHomeDir, "${DateTime.now().toIso8601String()}.yaml");
    Hive.registerAdapter("Settings", (dynamic json) => Settings.fromJson(json));
    Hive.registerAdapter("Profiles", (dynamic json) => Profiles.fromJson(json));
    final settings = Settings.settings;
    await clashCore.setHomeDir(Directory(settings.homeDir));
    await clashCore.setProfilePath(Profiles.profiles.currentProfilePath);
    clashCore.setExternalControllerAddress(
        "${settings.externalControllerBaseAddress}:${settings.externalControllerPort}");
    await apis.init();
    await clashCore.launch();
    await windowManager.show();
    await windowManager.focus();
  });
  runApp(const ProviderScope(child: App()));
}

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(stdoutProvider);
    final status = ref.watch(coreStatusProvider);
    return status.when(
        loading: () => const MaterialApp(
            home: Scaffold(body: Center(child: CircularProgressIndicator()))),
        error: (e, s) => MaterialApp(
              home: Scaffold(
                body: Center(
                  child: TextButton(
                    onPressed: () async {
                      await clashCore.reboot();
                    },
                    child:
                        const Text("Clash core errors, click here to reboot!"),
                  ),
                ),
              ),
            ),
        data: (status) {
          if (status == CoreStatus.shutdown) {
            return MaterialApp(
              home: Scaffold(
                body: Center(
                  child: TextButton(
                    onPressed: () async {
                      await clashCore.launch();
                    },
                    child: const Text(
                        "Clash core is not runnig, click here to launch!"),
                  ),
                ),
              ),
            );
          }
          if (status == CoreStatus.err) {
            return MaterialApp(
              home: Scaffold(
                body: Center(
                  child: TextButton(
                    onPressed: () async {
                      await clashCore.reboot();
                    },
                    child:
                        const Text("Clash core errors, click here to reboot!"),
                  ),
                ),
              ),
            );
          }
          return const MaterialApp(home: HomePage());
        });
  }
}
