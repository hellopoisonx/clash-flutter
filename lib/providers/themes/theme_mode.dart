import 'package:clash_flutter/providers/core/core_status.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_mode.g.dart';

@riverpod
class ThemeModeNotifier extends _$ThemeModeNotifier {
  @override
  ThemeMode build() => ThemeMode.system;

  set mode(ThemeMode m) {
    state = m;
    ref.invalidate(coreStatusProvider);
  }
}
