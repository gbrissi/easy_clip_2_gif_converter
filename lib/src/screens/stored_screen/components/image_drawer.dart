import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/image_drawer_controller.dart';
import 'image_drawer_btn.dart';
import 'image_drawer_info.dart';

class ImageDrawer extends StatelessWidget {
  const ImageDrawer({
    super.key,
    required this.height,
    required this.file,
  });
  final double height;
  final File file;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ImageDrawerController(),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ImageDrawerInfo(
            height: height,
            file: file,
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 12),
            child: ImageDrawerBtn(),
          ),
        ],
      ),
    );
  }
}
