import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:easy_clip_2_gif/src/global_controllers/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WindowTitleBar extends StatelessWidget {
  const WindowTitleBar({super.key});

  WindowButtonColors _getWindowButtonColor(bool isDarkMode) {
    return WindowButtonColors(
      iconNormal: !isDarkMode ? Colors.grey.shade900 : Colors.grey.shade200,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WindowTitleBarBox(
      child: Consumer<ThemeController>(
        builder: (context, controller, child) {
          final windowButtonColor = _getWindowButtonColor(
            controller.isDarkMode,
          );

          return Row(
            children: [
              Expanded(child: MoveWindow()),
              MinimizeWindowButton(colors: windowButtonColor),
              MaximizeWindowButton(colors: windowButtonColor),
              CloseWindowButton(colors: windowButtonColor),
            ],
          );
        },
      ),
    );
  }
}
