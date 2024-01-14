import 'dart:io';

import 'package:easy_clip_2_gif/src/utils/show_file_in_folder.dart';
import 'package:easy_clip_2_gif/src/utils/show_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

Future<void> downloadFile(BuildContext context, File file) async {
  String downloadsPath = (await getDownloadsDirectory())!.path;
  String filename = file.path.split("\\").last;
  File downloadFile = File("$downloadsPath\\$filename");
  downloadFile.writeAsBytesSync(file.readAsBytesSync());

  if (context.mounted) {
    SnackbarResult.success(
      context,
      text: "File successfully downloaded.",
      pressText: PressText(
        onPressed: () => showFileInFolder(downloadFile),
        text: "Open in folder",
      ),
    );
  }
}
