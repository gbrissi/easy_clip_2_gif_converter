import 'dart:io';

import 'package:easy_clip_2_gif/src/global_controllers/video_panel_controller.dart';
import 'package:easy_clip_2_gif/src/services/gif_converter.dart';
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

  void _convertVid() {
    GifConverter.convertClipToGIF(
      file: widget.file,
      name: "teste",
      framerate: 10,
      resolution: const Size(320, -1),
      range: DurationRange(
        start: const Duration(milliseconds: 0),
        end: const Duration(milliseconds: 10000),
      ),
    ).then(
      (String? filePath) {
        print("Dados: $filePath");
        if (filePath != null) {
          _vidPanelController.addGifToVid(
            widget.file,
            File(filePath),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      label: const Text("Convert video to GIF"),
      onPressed: _convertVid,
      icon: const Icon(
        Icons.chevron_right,
        size: 16,
      ),
    );
  }
}
