import 'package:flutter/material.dart';
import 'package:media_kit_video/media_kit_video.dart';

class AppVideoPlayer extends StatelessWidget {
  const AppVideoPlayer({
    super.key,
    required this.controller,
  });
  final VideoController controller;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        width: 320,
        child: Material(
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: Video(
              // controls: (state) => AdaptiveVideoControls(state),
              controller: controller,
            ),
          ),
        ),
      ),
    );
  }
}
