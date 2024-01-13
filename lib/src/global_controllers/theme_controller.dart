import 'package:easy_clip_2_gif/src/models/theme_mode.dart';
import 'package:easy_clip_2_gif/src/themes/light_theme.dart';
import 'package:flutter/material.dart' hide ThemeMode;

import '../services/shared_prefs.dart';

class ThemeController extends ChangeNotifier {
  ThemeData selectedTheme = lightTheme;
  bool get isDarkMode => selectedTheme.brightness == Brightness.dark;

  _setThemeFromPrefs() async {
    final ThemeData theme = await SharedPrefs.getTheme();
    _switchTheme(theme);
  }

  _switchTheme(ThemeData theme) {
    selectedTheme = theme;
    notifyListeners();
  }

  Future<void> setTheme(ThemeMode mode) async {
    selectedTheme = themeFromMode(mode);
    await SharedPrefs.setTheme(mode);

    _switchTheme(selectedTheme);
  }

  ThemeController() {
    _setThemeFromPrefs();
  }
}
