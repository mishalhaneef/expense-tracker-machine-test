import 'package:expense_tracker_machine_test/constants/constants.dart';
import 'package:flutter/material.dart';

final darkColorScheme = ColorScheme.fromSeed(
  seedColor: Colors.blue,
  brightness: Brightness.dark,
  surface: Palatte.theme,
  primaryContainer: const Color.fromRGBO(18, 18, 18, 1),
  // surface: Palatte.surfaceTheme,
  onSecondary: Palatte.surfaceTheme,
);

class AppTheme {
  static const AppBarTheme appBarTheme =
      AppBarTheme(backgroundColor: Palatte.theme);
  static const DividerThemeData dividerTheme =
      DividerThemeData(color: Palatte.dividerTheme);
}
