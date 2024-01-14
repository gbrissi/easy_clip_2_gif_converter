import 'dart:io';

import 'package:easy_clip_2_gif/src/global_controllers/video_panel_controller.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:mime/mime.dart';
import 'package:provider/provider.dart';

import '../../../utils/show_snackbar.dart';

class HomeAddVid extends StatefulWidget {
  const HomeAddVid({super.key});

  @override
  State<HomeAddVid> createState() => _HomeAddVidState();
}

class _HomeAddVidState extends State<HomeAddVid> {
  late final controller = context.read<VideoPanelController>();

  Future<void> _addClip() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
    );

    if (result != null) {
      for (PlatformFile platformFile in result.files) {
        final File file = File(platformFile.path!);
        final String? mimeType = lookupMimeType(file.path);

        if (mimeType?.startsWith('video/') ?? false) {
          controller.addVid(file);
        } else {
          if (mounted) {
            final String filename = file.path.split('\\').last;

            SnackbarResult.failure(
              context,
              text: 'The file "$filename" isn\'t a video',
            );
          }
        }
      }
    } 
  }

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      icon: const Icon(Icons.add),
      label: const Text("Add new videos"),
      onPressed: _addClip,
    );
  }
}
