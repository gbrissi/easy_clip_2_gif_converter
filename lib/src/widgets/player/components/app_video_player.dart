import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'controls_overlay.dart';

class AppVideoPlayer extends StatelessWidget {
  const AppVideoPlayer({
    super.key,
    required this.controller,
  });
  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        width: 320,
        child: Material(
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                VideoPlayer(controller),
                ControlsOverlay(controller: controller),
                VideoProgressIndicator(controller, allowScrubbing: true),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
