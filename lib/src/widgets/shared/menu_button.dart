import 'package:easy_clip_2_gif/src/widgets/shared/row_separated.dart';
import 'package:flutter/material.dart';

import 'color_theme.dart';

class Item<T> {
  final T value;
  final String name;

  Item({
    required this.value,
    required this.name,
  });
}

class MenuButton<T> extends StatefulWidget {
  const MenuButton({
    super.key,
    required this.selectedItem,
    required this.items,
    required this.icon,
    required this.itemBuilder,
  });
  final Item selectedItem;
  final List<Item<T>> items;
  final MenuItemButton Function(Item item) itemBuilder;
  final IconData icon;

  @override
  State<MenuButton> createState() => _MenuButtonState();
}

class _MenuButtonState extends State<MenuButton> {
  void _updateAnchorState(MenuController controller) {
    if (controller.isOpen) {
      controller.close();
    } else {
      controller.open();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      builder: (context, controller, child) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => _updateAnchorState(controller),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                child: ColorTheme(
                  color: Theme.of(context).colorScheme.primary,
                  child: RowSeparated(
                    spacing: 8,
                    children: [
                      Icon(
                        widget.icon,
                      ),
                      Text(
                        widget.selectedItem.name,
                      ),
                      const Icon(
                        Icons.expand_more,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
      menuChildren: widget.items
          .map<MenuItemButton>((item) => widget.itemBuilder(item))
          .toList(),
    );
  }
}
