import 'dart:io';

import 'package:easy_clip_2_gif/src/widgets/player/components/info_digits.dart';
import 'package:easy_clip_2_gif/src/widgets/player/components/info_size.dart';
import 'package:easy_clip_2_gif/src/widgets/player/components/info_text.dart';
import 'package:easy_clip_2_gif/src/widgets/shared/column_separated.dart';
import 'package:flutter/material.dart';
import 'package:mime/mime.dart';
import 'package:video_player/video_player.dart';

import 'convert_clip_button.dart';
import 'info_range.dart';
import 'info_section.dart';

class ConvertInfo extends StatefulWidget {
  const ConvertInfo({
    super.key,
    required this.file,
    required this.controller,
  });
  final File file;
  final VideoPlayerController controller;

  @override
  State<ConvertInfo> createState() => _ConvertInfoState();
}

class _ConvertInfoState extends State<ConvertInfo> {
  String get filename => widget.file.path.split('\\').last.split(".").first;
  int get fileSizeInBytes => widget.file.lengthSync();
  double get fileSizeInKB => fileSizeInBytes / 1024;
  String get fileSizeView => "${fileSizeInKB.toStringAsFixed(2)}KB";
  Size get resSize => widget.controller.value.size;
  String get resolution => "${resSize.width.toInt()}x${resSize.height.toInt()}";
  String get duration => formatDuration(widget.controller.value.duration);
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
    return ColumnSeparated(
      spacing: 4,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InfoSection(
          label: "video details",
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
        ),
        InfoSection(
          label: "gif convert config",
          children: [
            InfoText(
              edit: true,
              label: "name",
              text: filename,
            ),
            const InfoSize(
              aspectRatio: 16 / 9,
              minSize: Size(380, (380 / (16 / 9))),
              size: Size(380, (380 / (16 / 9))),
              label: "resolution",
            ),
            const InfoDigits(
              initialValue: 10,
              allowAbsOnly: true,
              label: "framerate",
            ),
            InfoRange(
              label: "duration",
              startValue: 0.0,
              endValue: widget.controller.value.duration.inMilliseconds / 1000,
              max: widget.controller.value.duration,
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ConvertClipButton(
                file: widget.file,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
