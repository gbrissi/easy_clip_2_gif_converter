import 'package:easy_clip_2_gif/src/controllers/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GifCardButton extends StatelessWidget {
  const GifCardButton({
    super.key,
    required this.icon,
    required this.color,
    required this.onTap,
  });
  final IconData icon;
  final Color color;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
        color: color,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Consumer<ThemeController>(
              builder: (context, provider, child) {
                return Icon(
                  icon,
                  color: !provider.isDarkMode
                      ? Colors.white
                      : Colors.grey.shade900,
                  size: 18,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
