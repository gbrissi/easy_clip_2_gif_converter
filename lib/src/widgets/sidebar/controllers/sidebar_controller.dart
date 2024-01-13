import 'package:easy_clip_2_gif/router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../constants/routes.dart';

class SidebarController extends ChangeNotifier {
  String currentRoute = Routes.home.path;
  final BuildContext context =
      appRouter.routerDelegate.navigatorKey.currentContext!;

  void _updateRoute() {
    final String? newRoute =
        GoRouter.of(context).routeInformationProvider.value.location;

    if (newRoute != null) {
      currentRoute = newRoute;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    GoRouter.of(context).routeInformationProvider.removeListener(_updateRoute);

    super.dispose();
  }

  SidebarController() {
    _updateRoute();
    GoRouter.of(context).routeInformationProvider.addListener(_updateRoute);
  }
}
