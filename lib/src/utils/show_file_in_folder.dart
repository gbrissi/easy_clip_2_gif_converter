import 'dart:io';

import 'package:path/path.dart';
import 'package:open_file/open_file.dart';

showFileInFolder(File file) {
  final String filePath = file.path;
  final String dirPath = dirname(filePath);

  // File highlight is currently only supported on Windows.
  if (Platform.isWindows) {
    Process.run('explorer.exe ', [
      '/select,',
      filePath,
    ]);
  } else {
    OpenFile.open(
      dirPath,
    );
  }
}
