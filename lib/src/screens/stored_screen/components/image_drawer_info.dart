import 'dart:io';

import 'package:easy_clip_2_gif/src/global_controllers/theme_controller.dart';
import 'package:easy_clip_2_gif/src/widgets/player/components/info_section.dart';
import 'package:easy_clip_2_gif/src/widgets/player/components/info_text.dart';
import 'package:easy_clip_2_gif/src/widgets/shared/color_theme.dart';
import 'package:easy_clip_2_gif/src/widgets/shared/column_separated.dart';
import 'package:flutter/material.dart';
import 'package:mime/mime.dart';
import 'package:provider/provider.dart';

import '../providers/image_drawer_controller.dart';

class ImageDrawerInfo extends StatefulWidget {
  const ImageDrawerInfo({
    super.key,
    required this.height,
    required this.file,
  });
  final double height;
  final File file;

  @override
  State<ImageDrawerInfo> createState() => _ImageDrawerInfoState();
}

class _ImageDrawerInfoState extends State<ImageDrawerInfo> {
  String get filename => widget.file.path.split('\\').last.split(".").first;
  int get fileSizeInBytes => widget.file.lengthSync();
  double get fileSizeInKB => fileSizeInBytes / 1024;
  String get fileSizeView => "${fileSizeInKB.toStringAsFixed(2)}KB";
  // Size get resSize => widget.controller.value.size;
  // String get resolution => "${resSize.width.toInt()}x${resSize.height.toInt()}";
  // String get duration => formatDuration(widget.controller.value.duration);
  String get filetype =>
      lookupMimeType(
        widget.file.path,
      ) ??
      "unknown";

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));

    if (duration.inHours > 0) {
      return '${duration.inHours}:$twoDigitMinutes:$twoDigitSeconds';
    } else {
      return '$twoDigitMinutes:$twoDigitSeconds';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<ImageDrawerController, ThemeController>(
      builder: (context, imgProvider, themeProvider, child) {
        return AnimatedContainer(
          width: imgProvider.isOpen ? 220 : 0,
          height: widget.height,
          duration: const Duration(
            milliseconds: 300,
          ),
          child: Card(
            // color: ,
            child: Container(
              margin: const EdgeInsets.only(left: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                // color: Theme.of(context).colorScheme.secondary,
              ),
              child: ColorTheme(
                color: Theme.of(context).textTheme.bodyMedium!.color!,
                // color: themeProvider.isDarkMode
                //     ? Colors.grey.shade900
                //     : Colors.grey.shade200,
                child: SingleChildScrollView(
                  child: ColumnSeparated(
                    spacing: 4,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InfoSection(
                        label: "image overview",
                        children: [
                          InfoText(
                            label: "name",
                            text: filename,
                          ),
                          InfoText(
                            label: "path",
                            text: widget.file.path,
                          ),
                          InfoText(
                            label: "size",
                            text: fileSizeView,
                          ),
                          InfoText(
                            label: "type",
                            text: filetype,
                          ),
                          // InfoText(
                          //   label: "duration",
                          //   text: duration,
                          // ),
                          // InfoText(
                          //   label: "resolution",
                          //   text: resolution,
                          // ),
                        ],
                      ),
                    ],
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
