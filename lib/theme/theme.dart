import 'package:flutter/material.dart';
import 'package:rick_and_morty_test/theme/color_schemes.g.dart';

class AppTheme {
  static final ThemeData theme =
      ThemeData(useMaterial3: true, colorScheme: darkColorScheme).copyWith();
}
