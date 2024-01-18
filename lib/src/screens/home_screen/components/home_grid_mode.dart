import 'package:easy_clip_2_gif/src/extensions/string_extension.dart';
import 'package:easy_clip_2_gif/src/widgets/player/providers/layout_controller.dart';
import 'package:easy_clip_2_gif/src/widgets/shared/menu_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controllers/video_panel_controller.dart';

class HomeGridMode extends StatefulWidget {
  const HomeGridMode({super.key});

  @override
  State<HomeGridMode> createState() => _HomeGridModeState();
}

class _HomeGridModeState extends State<HomeGridMode> {
  late final _layoutController = context.read<LayoutController>();
  late Item _curOption;

  List<Item<Layout>> get _layoutsItems => Layout.values
      .map((e) => Item<Layout>(value: e, name: e.name.capitalize()))
      .toList();

  void _setViewMode(Item item) => _layoutController.setLayout(item.value);

  void _updateOption() {
    final newOption = _getItemFromLayout(_layoutController.layout);
    if (newOption != _curOption && mounted) {
      setState(() {
        _curOption = newOption;
      });
    }
  }

  bool _compareStandardizedValues(String val1, String val2) {
    if (val1.toLowerCase() == val2.toLowerCase()) {
      return true;
    }

    return false;
  }

  Item _getItemFromLayout(Layout layout) => _layoutsItems
      .firstWhere((item) => _compareStandardizedValues(item.name, layout.name));

  @override
  void initState() {
    _curOption = _getItemFromLayout(_layoutController.layout);
    _layoutController.addListener(
      _updateOption,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<VideoPanelController>(
      builder: (context, provider, child) {
        if (provider.videos.isNotEmpty) {
          return IntrinsicWidth(
            child: MenuButton<Layout>(
              icon: Icons.grid_view,
              selectedItem: _curOption,
              items: _layoutsItems,
              itemBuilder: (item) => MenuItemButton(
                onPressed: () => _setViewMode(item),
                child: Text(item.name),
              ),
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
