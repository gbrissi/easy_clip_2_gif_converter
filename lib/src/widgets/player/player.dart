import 'package:easy_clip_2_gif/src/global_controllers/video_panel_controller.dart';
import 'package:easy_clip_2_gif/src/widgets/player/components/remove_video_button.dart';
import 'package:easy_clip_2_gif/src/widgets/player/providers/player_layout_controller.dart';
import 'package:easy_clip_2_gif/src/widgets/shared/row_separated.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import 'components/app_video_player.dart';
import 'components/convert_info.dart';
import 'components/converted_gif_info.dart';
import 'components/gif_card_button.dart';
import 'components/save_gif_button.dart';
import 'components/player_layout.dart';

class Player extends StatefulWidget {
  const Player({
    super.key,
    required this.convertVid,
  });
  final ConvertVideo convertVid;

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  late VideoPlayerController _controller;
  late final _videoPanelController = context.read<VideoPanelController>();
  ColorScheme get _btnColorScheme => Theme.of(context).buttonTheme.colorScheme!;

  void _downloadGif() {}

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(widget.convertVid.video)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });

    _videoPanelController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  Widget? get _resultCard => widget.convertVid.gif?.existsSync() ?? false
      ? SizedBox(
          width: double.infinity,
          child: Card(
            color: Theme.of(context).canvasColor.withOpacity(0.7),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Stack(
                children: [
                  RowSeparated(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 4,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: SizedBox(
                          width: 320,
                          child: Material(
                            child: AspectRatio(
                              aspectRatio: 16 / 9,
                              child: Image.file(
                                widget.convertVid.gif!,
                              ),
                            ),
                          ),
                        ),
                      ),
                      ConvertedGifInfo(
                        file: widget.convertVid.gif!,
                      ),
                    ],
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: RowSeparated(
                      spacing: 4,
                      children: [
                        SaveGifButton(
                          file: widget.convertVid.gif!,
                        ),
                        GifCardButton(
                          color: _btnColorScheme.secondary,
                          icon: Icons.download,
                          onTap: _downloadGif,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      : null;

  @override
  Widget build(BuildContext context) {
    return PlayerLayout(
      views: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Stack(
              children: [
                Positioned(
                  right: 0,
                  top: 0,
                  child: RemoveVideoButton(
                    filePath: widget.convertVid.video.path,
                  ),
                ),
                RowSeparated(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 12,
                  children: [
                    AppVideoPlayer(
                      controller: _controller,
                    ),
                    ConvertInfo(
                      controller: _controller,
                      file: widget.convertVid.video,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        _resultCard,
      ].where((e) => e != null).cast<Widget>().toList(),
    );
  }
}
