import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:easy_clip_2_gif/src/widgets/sidebar/sidebar.dart';
import 'package:flutter/material.dart';

import 'components/dynamic_wrapper.dart';
import 'components/window_title_bar.dart';

class AppShell extends StatelessWidget {
  const AppShell({
    super.key,
    required this.child,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: Scaffold(
        body: Row(
          children: [
            const Sidebar(),
            Expanded(
              child: Column(
                children: [
                  const WindowTitleBar(),
                  Expanded(
                    child: DynamicWrapper(
                      child: child,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
