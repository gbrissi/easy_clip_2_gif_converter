import 'package:easy_clip_2_gif/src/controllers/theme_controller.dart';
import 'package:easy_clip_2_gif/src/screens/stored_screen/providers/image_drawer_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ImageDrawerBtn extends StatelessWidget {
  const ImageDrawerBtn({super.key});
  Radius get _radius => const Radius.circular(4);

  @override
  Widget build(BuildContext context) {
    return Consumer2<ImageDrawerController, ThemeController>(
      builder: (context, drawerProvider, themeProvider, child) {
        return Card(
          shape: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.only(
              topRight: _radius,
              bottomRight: _radius,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topRight: _radius,
              bottomRight: _radius,
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: drawerProvider.isOpen
                    ? drawerProvider.closeDrawer
                    : drawerProvider.openDrawer,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                  ),
                  child: Icon(
                    drawerProvider.isOpen
                        ? Icons.chevron_left
                        : Icons.chevron_right,
                    size: 12,
                    // color: !themeProvider.isDarkMode
                    //     ? Colors.white
                    //     : Colors.grey.shade900,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
