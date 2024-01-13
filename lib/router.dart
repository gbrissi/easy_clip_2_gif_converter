import 'package:easy_clip_2_gif/src/constants/routes.dart';
import 'package:easy_clip_2_gif/src/screens/home_screen/home_screen.dart';
import 'package:easy_clip_2_gif/src/screens/stored_screen/stored_screen.dart';
import 'package:easy_clip_2_gif/src/widgets/shell/shell.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

typedef GoRouteBuilder = Widget Function(
  BuildContext context,
  GoRouterState state,
);

GoRoute createRoute(SpecializedRoute route, GoRouteBuilder builder) {
  return GoRoute(
    name: route.name,
    path: route.path,
    pageBuilder: (context, state) => NoTransitionPage(
      child: builder(context, state),
    ),
  );
}

final appRouter = GoRouter(
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return AppShell(
          child: child,
        );
      },
      routes: [
        createRoute(
          Routes.home,
          (context, state) => const HomeScreen(),
        ),
        createRoute(
          Routes.saved,
          (context, state) => const StoredScreen(),
        )
      ],
    )
  ],
);
