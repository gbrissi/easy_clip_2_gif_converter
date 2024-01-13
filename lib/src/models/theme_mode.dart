import 'package:collection/collection.dart';
import 'package:easy_clip_2_gif/src/themes/dark_theme.dart';
import 'package:easy_clip_2_gif/src/themes/light_theme.dart';
import 'package:flutter/material.dart' hide ThemeMode;

enum ThemeMode {
  dark,
  light,
}

ThemeMode themeModeFromString(String? mode) =>
    ThemeMode.values.firstWhereOrNull(
      (curMode) => curMode.name == mode,
    ) ??
    ThemeMode.light;

ThemeData themeFromMode(ThemeMode mode) =>
    mode == ThemeMode.dark ? darkTheme : lightTheme;
