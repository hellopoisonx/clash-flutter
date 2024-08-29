import 'package:clash_flutter/exception/exception.dart';
import 'package:clash_flutter/pages/home.dart';
import 'package:clash_flutter/providers/apis/apis.dart';
import 'package:clash_core/clash_core.dart';
import 'package:clash_flutter/providers/core/core_status.dart';
import 'package:clash_flutter/providers/logs/logs.dart';
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
  runApp(const ProviderScope(child: App()));
}

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    MyException.context = context;
    final status = ref.watch(coreStatusProvider);
    ref.watch(logsProvider);
    ref.watch(apisProvider);
    return MaterialApp(
        home: status == CoreStatus.shutdown
            ? Center(
                child: TextButton(
                    onPressed: () => ref.invalidate(coreStatusProvider),
                    child: const Text(
                        "Clash Core is shutdown, click here to launch")),
              )
            : const HomePage());
  }
}
