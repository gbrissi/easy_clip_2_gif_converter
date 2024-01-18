import 'package:easy_clip_2_gif/src/controllers/video_panel_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../widgets/player/player.dart';

final List<String> widgets = ["Um", "Dois"];

class HomeVidGrid extends StatelessWidget {
  const HomeVidGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<VideoPanelController, List<ConvertVideo>>(
      selector: (_, provider) => provider.videos,
      builder: (context, videos, child) {
        if (videos.isNotEmpty) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: ListView(
              shrinkWrap: true,
              children: videos.map((video) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Player(
                    convertVid: video,
                  ),
                );
              }).toList(),
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
