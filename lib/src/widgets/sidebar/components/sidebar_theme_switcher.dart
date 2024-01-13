import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:easy_clip_2_gif/src/global_controllers/theme_controller.dart';
import 'package:easy_clip_2_gif/src/widgets/shared/row_separated.dart';
import 'package:flutter/material.dart' hide ThemeMode;
import 'package:provider/provider.dart';

import '../../../models/theme_mode.dart';

class SidebarThemeSwitcher extends StatefulWidget {
  const SidebarThemeSwitcher({
    super.key,
    required this.switcher,
  });
  final ThemeSwitcherState switcher;

  @override
  State<SidebarThemeSwitcher> createState() => _SidebarThemeSwitcherState();
}

class _SidebarThemeSwitcherState extends State<SidebarThemeSwitcher> {
  late final themeController = context.read<ThemeController>();
  late bool isDarkMode;

  IconData get icon => isDarkMode ? Icons.light_mode : Icons.dark_mode;

  void _switchTheme() {
    themeController.setTheme(
      isDarkMode ? ThemeMode.light : ThemeMode.dark,
    );
  }

  void _listenToThemeChanges() {
    if (isDarkMode != themeController.isDarkMode && mounted) {
      setState(() {
        isDarkMode = themeController.isDarkMode;
      });

      // Set theme in switcher for animated theme lib.
      // TODO: RenderBox error without WidgetsBinding.
      // It seems like removing AnimatedThemeSwitcher lib would be the best approach.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          widget.switcher.changeTheme(
            theme: themeController.selectedTheme,
          );
        }
      });
    }
  }

  @override
  void initState() {
    isDarkMode = themeController.isDarkMode;
    themeController.addListener(_listenToThemeChanges);

    super.initState();
  }

  @override
  void dispose() {
    themeController.removeListener(_listenToThemeChanges);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RowSeparated(
      spacing: 8,
      mainAxisSize: MainAxisSize.min,
      children: [
        Switch(
          value: isDarkMode,
          onChanged: (_) => _switchTheme(),
        ),
        Icon(
          icon,
          color: Theme.of(context).iconTheme.color!.withOpacity(0.7),
        ),
      ],
    );
  }
}
