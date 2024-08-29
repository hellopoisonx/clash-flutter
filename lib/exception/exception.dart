import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyException {
  static BuildContext? context;

  final int level;
  final Object? error;
  final void Function()? recover;

  MyException({this.level = 0, this.error, this.recover});

  @override
  String toString() {
    super.toString();
    return error != null ? error.toString() : "Unknwon";
  }

  Future<void> show() async {
    if (context == null) {
      throw Exception("Context hasn't been initialized");
    }
    ScaffoldMessenger.of(context!).showSnackBar(
      SnackBar(
        content: Text(error.toString()),
        action: SnackBarAction(
          label: "retry",
          onPressed: () {
            if (recover != null) {
              recover!();
            }
          },
        ),
      ),
    );
    //await showDialog(
    //    context: context!,
    //    builder: (context) => AlertDialog(
    //          title: const Text("Error"),
    //          content: Text(error != null ? error.toString() : "Unknwon"),
    //          actions: [
    //            IconButton(
    //                tooltip: "Recover from errors",
    //                onPressed: recover,
    //                icon: const Icon(Icons.restore_rounded)),
    //            IconButton(
    //                tooltip: "Exit",
    //                onPressed: Navigator.of(context).pop,
    //                icon: const Icon(Icons.exit_to_app_rounded)),
    //          ],
    //        ));
  }
}

class MyObserver extends ProviderObserver {
  const MyObserver();
  @override
  void providerDidFail(
    ProviderBase<Object?> provider,
    Object error,
    StackTrace stackTrace,
    ProviderContainer container,
  ) {
    try {
      final err = error as MyException;
      print("error: ${err.error} $stackTrace");
      if (err.level > 0) {
        err.show();
      }
    } catch (e) {
      print("error: $error $stackTrace");
      MyException(error: error).show();
    }
  }
}
