import 'dart:io';

import 'package:easy_clip_2_gif/src/utils/download_file.dart';
import 'package:easy_clip_2_gif/src/utils/show_file_in_folder.dart';
import 'package:flutter/material.dart';

import '../../../widgets/player/components/gif_card_button.dart';
import '../../../widgets/shared/row_separated.dart';
import 'image_drawer.dart';

class ImageFileData extends StatefulWidget {
  const ImageFileData({
    super.key,
    required this.file,
  });
  final File file;

  @override
  State<ImageFileData> createState() => _ImageFileDataState();
}

class _ImageFileDataState extends State<ImageFileData> {
  ColorScheme get _btnColorScheme => Theme.of(context).buttonTheme.colorScheme!;
  double? _imgHeight;
  final GlobalKey _imgKey = GlobalKey();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          _imgHeight = _imgKey.currentContext!.size!.height;
        });
      }
    });

    super.initState();
  }

  void _downloadGif() => downloadFile(
        context,
        widget.file,
      );

  void _openFileLocation() => showFileInFolder(
        widget.file,
      );

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          children: [
            ClipRRect(
              key: _imgKey,
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                width: 320,
                child: Material(
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Image.file(
                      widget.file,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 4,
              right: 4,
              child: RowSeparated(
                spacing: 4,
                children: [
                  GifCardButton(
                    color: _btnColorScheme.primary,
                    icon: Icons.folder,
                    onTap: _openFileLocation,
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
        _imgHeight != null
            ? ImageDrawer(
                file: widget.file,
                height: _imgHeight!,
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
