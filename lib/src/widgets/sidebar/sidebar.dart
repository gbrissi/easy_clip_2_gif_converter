import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:easy_clip_2_gif/src/constants/routes.dart';
import 'package:easy_clip_2_gif/src/global_controllers/theme_controller.dart';
import 'package:easy_clip_2_gif/src/widgets/shared/column_separated.dart';
import 'package:easy_clip_2_gif/src/widgets/sidebar/components/language_selector.dart';
import 'package:easy_clip_2_gif/src/widgets/sidebar/components/sidebar_section.dart';
import 'package:easy_clip_2_gif/src/widgets/sidebar/controllers/sidebar_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/sidebar_item.dart';
import 'components/sidebar_logo.dart';
import 'components/sidebar_theme_switcher.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeController>(
      builder: (context, value, child) {
        return Padding(
          padding: const EdgeInsets.all(8),
          child: Card(
            // color: value.isDarkMode ? Colors.grey.shade900 : const Color.fromARGB(255, 250, 250, 250),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: ChangeNotifierProvider(
                create: (_) => SidebarController(),
                child: ColumnSeparated(
                  spacing: 8,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SidebarLogo(),
                    SidebarSection(
                      label: "Overview",
                      items: [
                        SidebarItem(
                          icon: Icons.cached,
                          route: Routes.home,
                        ),
                        SidebarItem(
                          icon: Icons.inventory_2,
                          route: Routes.saved,
                        ),
                      ],
                    ),
                    Expanded(
                      child: ColumnSeparated(
                        spacing: 4,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const LanguageSelector(),
                          ThemeSwitcher.switcher(
                            builder: (context, switcher) {
                              return SidebarThemeSwitcher(
                                switcher: switcher,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
