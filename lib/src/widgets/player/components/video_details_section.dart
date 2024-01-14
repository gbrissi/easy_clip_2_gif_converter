import 'package:flutter/material.dart';

import 'info_section.dart';
import 'info_text.dart';

class VideoDetailsSection extends StatelessWidget {
  const VideoDetailsSection({
    super.key,
    required this.filename,
    required this.path,
    required this.fileSize,
    required this.duration,
    required this.filetype,
    required this.resolution,
  });
  final String filename;
  final String path;
  final String fileSize;
  final String duration;
  final String filetype;
  final String resolution;

  @override
  Widget build(BuildContext context) {
    return InfoSection(
      label: "video details",
      children: [
        InfoText(
          label: "name",
          text: filename,
        ),
        InfoText(
          label: "path",
          text: path,
        ),
        InfoText(
          label: "size",
          text: fileSize,
        ),
        InfoText(
          label: "duration",
          text: duration,
        ),
        InfoText(
          label: "type",
          text: filetype,
        ),
        InfoText(
          label: "resolution",
          text: resolution,
        ),
      ],
    );
  }
}
