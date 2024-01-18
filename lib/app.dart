import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:easy_clip_2_gif/router.dart';
import 'package:easy_clip_2_gif/src/controllers/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeController(),
      child: const Main(),
    );
  }
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<ThemeController>();

    return ThemeProvider(
      initTheme: controller.selectedTheme,
      builder: (context, theme) {
        return MaterialApp.router(
          routerConfig: appRouter,
          title: 'EasyClip2Gif',
          debugShowCheckedModeBanner: false,
          theme: theme,
        );
      },
    );
  }
}
