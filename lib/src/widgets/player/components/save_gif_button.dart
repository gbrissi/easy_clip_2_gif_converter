import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import '../../../services/gif_converter.dart';
import '../../../utils/show_snackbar.dart';
import 'gif_card_button.dart';

class SaveGifButton extends StatefulWidget {
  const SaveGifButton({
    super.key,
    required this.file,
  });
  final File file;

  @override
  State<SaveGifButton> createState() => _SaveGifButtonState();
}

class _SaveGifButtonState extends State<SaveGifButton> {
  Color get _btnColor => Theme.of(context).buttonTheme.colorScheme!.primary;

  Future<void> _saveGif() async {
    final bool fileExists = await _checkIfFileIsStored();

    if (mounted) {
      if (!fileExists) {
        GifConverter.storeFileInAppDocuments(
          widget.file,
        ).then((_) {
          SnackbarResult.success(
            context,
            text: "File has successfully been stored.",
          );
        });
      } else {
        // TODO: Move file to temporary folder again.
        SnackbarResult.failure(
          context,
          text: "File is already stored.",
        );
      }
    }
  }

  Future<bool> _checkIfFileIsStored() async {
    final String filename = widget.file.path.split('\\').last;
    final Directory appDir = await getApplicationDocumentsDirectory();
    final String storeDirPath = "${appDir.path}\\gifs";

    final File storedFile = File("$storeDirPath\\$filename");
    final bool fileExists = await storedFile.exists();

    return fileExists;
  }

  @override
  Widget build(BuildContext context) {
    return GifCardButton(
      color: _btnColor,
      icon: Icons.save,
      onTap: _saveGif,
    );
  }
}
