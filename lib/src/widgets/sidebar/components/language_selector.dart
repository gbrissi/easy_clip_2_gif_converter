import 'package:easy_clip_2_gif/src/widgets/shared/menu_button.dart';
import 'package:flutter/material.dart';

const List<String> menuOptions = [
  "Portuguese",
  "English",
];

class LanguageSelector extends StatefulWidget {
  const LanguageSelector({super.key});

  @override
  State<LanguageSelector> createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector> {
  // TODO: Temporary language selector (not associated with a controller);
  late Item _curItem = menuItems[1];
  List<Item<String>> menuItems =
      menuOptions.map((e) => Item(value: e, name: e)).toList();

  void _updateLanguage(Item item) {
    setState(() {
      _curItem = item;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MenuButton<String>(
      icon: Icons.language,
      selectedItem: _curItem,
      items: menuItems,
      itemBuilder: (item) => MenuItemButton(
        onPressed: () => _updateLanguage(item),
        child: Text(item.name),
      ),
    );
  }
}
