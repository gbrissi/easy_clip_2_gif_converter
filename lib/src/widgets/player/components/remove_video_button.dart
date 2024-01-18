import 'package:easy_clip_2_gif/src/controllers/video_panel_controller.dart';
import 'package:easy_clip_2_gif/src/utils/show_confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class RemoveVideoButton extends StatefulWidget {
  const RemoveVideoButton({
    super.key,
    required this.filePath,
  });
  final String filePath;

  @override
  State<RemoveVideoButton> createState() => _RemoveVideoButtonState();
}

class _RemoveVideoButtonState extends State<RemoveVideoButton> {
  late final _vidController = context.read<VideoPanelController>();

  void _removeVideo() {
    showConfirmDialog(
      context,
      onTap: (result) {
        if (result) {
          _vidController.removeVid(
            widget.filePath,
          );
        }

        context.pop();
      },
      title: "Remove video",
      description:
          "Do you want to remove the selected video from the grid selection?",
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: _removeVideo,
      icon: Icon(
        Icons.delete,
        color: Theme.of(context).buttonTheme.colorScheme!.secondary,
      ),
    );
  }
}
