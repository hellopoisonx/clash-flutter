import 'package:flutter/material.dart';

class MyException {
  static late BuildContext context;
  static Future<void> show({Object? error, void Function()? recover}) async {
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Error"),
              content: Text(error != null ? error.toString() : "Unknwon"),
              actions: [
                IconButton(
                    tooltip: "Recover from errors",
                    onPressed: recover,
                    icon: const Icon(Icons.restore_rounded)),
                IconButton(
                    tooltip: "Exit",
                    onPressed: Navigator.of(context).pop,
                    icon: const Icon(Icons.exit_to_app_rounded)),
              ],
            ));
  }
}
