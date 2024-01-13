import 'dart:io';

import 'package:easy_clip_2_gif/src/widgets/player/components/info_digits.dart';
import 'package:easy_clip_2_gif/src/widgets/player/components/info_size.dart';
import 'package:easy_clip_2_gif/src/widgets/player/components/info_text.dart';
import 'package:easy_clip_2_gif/src/widgets/shared/column_separated.dart';
import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:mime/mime.dart';

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
  final VideoController controller;

  @override
  State<ConvertInfo> createState() => _ConvertInfoState();
}

class _ConvertInfoState extends State<ConvertInfo> {
  String get filename => widget.file.path.split('\\').last.split(".").first;
  int get fileSizeInBytes => widget.file.lengthSync();
  double get fileSizeInKB => fileSizeInBytes / 1024;
  String get fileSizeView => "${fileSizeInKB.toStringAsFixed(2)}KB";

  PlayerState get _playerState => widget.controller.player.state;
  Duration get _playerDuration => _playerState.duration;
  String get duration => formatDuration(_playerDuration);

  double _getResValue(int? value) => value?.toDouble() ?? 0;
  String get resolution => "${resSize.width.toInt()}x${resSize.height.toInt()}";
  Size get resSize => Size(
        _getResValue(_playerState.width),
        _getResValue(_playerState.height),
      );

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
              endValue: _playerDuration.inMilliseconds / 1000,
              max: _playerDuration,
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
