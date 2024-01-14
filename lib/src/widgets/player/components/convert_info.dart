import 'dart:io';

import 'package:easy_clip_2_gif/src/widgets/player/components/video_details_section.dart';
import 'package:easy_clip_2_gif/src/widgets/shared/column_separated.dart';
import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:mime/mime.dart';
import 'package:provider/provider.dart';

import '../providers/gif_config_controller.dart';
import 'convert_clip_button.dart';
import 'gif_config_section.dart';

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
  String get filePath => widget.file.path;

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
        VideoDetailsSection(
          filename: filename,
          path: filePath,
          fileSize: fileSizeView,
          duration: duration,
          filetype: filetype,
          resolution: resolution,
        ),
        ChangeNotifierProvider(
          create: (_) => GIFConfigController(),
          child: ColumnSeparated(
            spacing: 4,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GIFConfigSection(
                filename: filename,
                videoDuration: _playerDuration,
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
          ),
        ),
      ],
    );
  }
}
