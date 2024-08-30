import 'package:clash_flutter/exception/exception.dart';
import 'package:clash_flutter/pages/home.dart';
import 'package:clash_core/clash_core.dart';
import 'package:clash_flutter/providers/core/core_status.dart';
import 'package:clash_flutter/providers/themes/theme_mode.dart';
import 'package:clash_flutter/themes/default.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_manager/window_manager.dart';

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
    await windowManager.show();
    await windowManager.focus();
  });
  runApp(const ProviderScope(observers: [
    MyObserver(),
  ], child: LaunchPage()));
}

class LaunchPage extends ConsumerWidget {
  const LaunchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeNotifierProvider);
    return MaterialApp(
      theme: light,
      darkTheme: dark,
      themeMode: themeMode,
      home: const App(),
    );
  }
}

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = ref.watch(coreStatusProvider);
    MyException.context = context;
    return Scaffold(
      body: status.when(
          data: (status) {
            return status == CoreStatus.shutdown
                ? Center(
                    child: TextButton(
                        onPressed: () => ref.invalidate(coreStatusProvider),
                        child: const Text(
                            "Clash Core is shutdown, click here to launch")),
                  )
                : status == CoreStatus.running
                    ? const HomePage()
                    : Center(
                        child: TextButton(
                            onPressed: () => ref.invalidate(coreStatusProvider),
                            child: const Text(
                                "Failed to launch clash core, click here to re-try")),
                      );
          },
          error: (e, s) {
            return Center(
              child: TextButton(
                  onPressed: () => ref.invalidate(coreStatusProvider),
                  child: Text("${e.toString()}, click here to re-try")),
            );
          },
          loading: () => const Center(
                child: CircularProgressIndicator(),
              )),
    );
  }
}
