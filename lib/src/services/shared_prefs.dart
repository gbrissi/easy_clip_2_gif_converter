import 'package:easy_clip_2_gif/src/models/theme_mode.dart';
import 'package:flutter/material.dart' hide ThemeMode;
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static const String themeKey = "theme";

  static Future<SharedPreferences> _getPrefs() async {
    // SharedPreferences.setMockInitialValues({});
    return await SharedPreferences.getInstance();
  }

  static Future<void> setTheme(ThemeMode theme) async {
    final SharedPreferences prefs = await _getPrefs();

    await prefs.setString(themeKey, theme.name);
  }

  static Future<ThemeData> getTheme() async {
    final SharedPreferences prefs = await _getPrefs();

    final ThemeMode themeMode = themeModeFromString(prefs.getString(themeKey));
    final ThemeData theme = themeFromMode(themeMode);

    return theme;
  }
}
