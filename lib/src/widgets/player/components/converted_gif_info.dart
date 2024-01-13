import 'dart:io';

import 'package:easy_clip_2_gif/src/widgets/player/components/info_section.dart';
import 'package:easy_clip_2_gif/src/widgets/player/components/info_text.dart';
import 'package:easy_clip_2_gif/src/widgets/shared/column_separated.dart';
import 'package:flutter/material.dart';

class ConvertedGifInfo extends StatefulWidget {
  const ConvertedGifInfo({
    super.key,
    required this.file,
  });
  final File file;

  @override
  State<ConvertedGifInfo> createState() => _ConvertedGifInfoState();
}

class _ConvertedGifInfoState extends State<ConvertedGifInfo> {
  String get filename => widget.file.path.split('\\').last.split(".").first;
  int get fileSizeInBytes => widget.file.lengthSync();
  double get fileSizeInKB => fileSizeInBytes / 1024;
  String get fileSizeView => "${fileSizeInKB.toStringAsFixed(2)}KB";
  String imageResolution = "unknown";

  @override
  void initState() {
    decodeImageFromList(widget.file.readAsBytesSync()).then((value) {
      if (mounted) {
        setState(() {
          imageResolution = "${value.width}x${value.height}";
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ColumnSeparated(
      spacing: 4,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InfoSection(
          label: "gif details",
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
              label: "resolution",
              text: imageResolution,
            )
          ],
        )
      ],
    );
  }
}
