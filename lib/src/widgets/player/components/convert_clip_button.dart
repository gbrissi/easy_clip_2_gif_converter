import 'dart:io';

import 'package:easy_clip_2_gif/src/controllers/video_panel_controller.dart';
import 'package:easy_clip_2_gif/src/services/gif_converter.dart';
import 'package:easy_clip_2_gif/src/widgets/player/providers/gif_config_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConvertClipButton extends StatefulWidget {
  const ConvertClipButton({
    super.key,
    required this.file,
  });
  final File file;

  @override
  State<ConvertClipButton> createState() => _ConvertClipButtonState();
}

class _ConvertClipButtonState extends State<ConvertClipButton> {
  late final _vidPanelController = context.read<VideoPanelController>();
  late final _gifConfigController = context.read<GIFConfigController>();
  bool isLoading = false;

  void _convertVid() {
    setState(() {
      isLoading = true;
    });

    GifConverter.convertClipToGIF(
      file: widget.file,
      name: _gifConfigController.filename,
      framerate: _gifConfigController.framerate,
      resolution: _gifConfigController.resolution,
      range: _gifConfigController.durationRange,
    ).then(
      (String? filePath) {
        if (filePath != null) {
          _vidPanelController.addGifToVid(
            widget.file,
            File(filePath),
          );
        }

        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      label: const Text("Convert video to GIF"),
      onPressed: !isLoading ? _convertVid : null,
      icon: const Icon(
        Icons.chevron_right,
        size: 16,
      ),
    );
  }
}
