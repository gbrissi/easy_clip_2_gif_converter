import 'package:easy_clip_2_gif/src/constants/routes.dart';
import 'package:easy_clip_2_gif/src/extensions/string_extension.dart';
import 'package:easy_clip_2_gif/src/widgets/sidebar/controllers/sidebar_controller.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../constants/text_styles.dart';
import '../../shared/row_separated.dart';

class SidebarItem extends StatefulWidget {
  const SidebarItem({
    super.key,
    required this.icon,
    required this.route,
  });

  final IconData icon;
  final SpecializedRoute route;

  @override
  State<SidebarItem> createState() => _SidebarItemState();
}

class _SidebarItemState extends State<SidebarItem> {
  late final sidebarController = context.read<SidebarController>();
  late String curRoute;
  bool get isRouteActive => _getRouteActiveResult();

  String get routeName =>
      (widget.route.viewName ?? widget.route.name).toLowerCase();

  Color get color => isRouteActive
      ? Theme.of(context).buttonTheme.colorScheme!.primary
      : Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(0.7);

  Color? get buttonColor => isRouteActive
      ? Theme.of(context).buttonTheme.colorScheme!.primary.withOpacity(0.3)
      : Colors.transparent;

  bool _getRouteActiveResult() {
    // TODO: Temporary. (intend to keep it active even on non-absolute path);
    return widget.route.path == curRoute;
  }

  viewRoute() {
    if (curRoute != widget.route.path && mounted) {
      context.goNamed(widget.route.name);
    }
  }

  void _keepRouteUpdated() {
    if (curRoute != sidebarController.currentRoute && mounted) {
      setState(() {
        curRoute = sidebarController.currentRoute;
      });
    }
  }

  @override
  void initState() {
    curRoute = sidebarController.currentRoute;
    sidebarController.addListener(_keepRouteUpdated);

    super.initState;
  }

  @override
  void dispose() {
    sidebarController.removeListener(_keepRouteUpdated);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(
        Radius.circular(8),
      ),
      child: Material(
        color: buttonColor,
        child: InkWell(
          onTap: viewRoute,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            child: SizedBox(
              width: 160,
              child: RowSeparated(
                spacing: 8,
                children: [
                  Icon(
                    widget.icon,
                    size: 16,
                    color: color,
                  ),
                  Text(
                    routeName,
                    style: TextStyles.navigation.apply(
                      color: color,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
