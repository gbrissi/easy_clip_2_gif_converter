import 'dart:async';
import 'dart:io';

import 'package:ffmpeg_helper/ffmpeg_helper.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class GifConverterArgument implements CliArguments {
  final int framerate;
  final Size res;
  const GifConverterArgument({
    required this.framerate,
    required this.res,
  });

  @override
  List<String> toArgs() {
    return [
      "-vf",
      "fps=$framerate,scale=${res.width}:${res.height}:flags=lanczos"
    ];
  }
}

class DurationRange {
  final Duration start;
  final Duration end;

  DurationRange({
    required this.start,
    required this.end,
  });
}

class GifConverter {
  static final FFMpegHelper ffmpeg = FFMpegHelper.instance;

  static Future<bool> downloadFFMpeg(
    void Function(FFMpegProgress) onProgress,
  ) async {
    bool success = false;

    if (Platform.isWindows) {
      success = await ffmpeg.setupFFMpegOnWindows(
        onProgress: onProgress,
      );
    }

    return success;
  }

  static Future<bool> checkFFMpeg() async {
    return await ffmpeg.isFFMpegPresent();
  }

  static Future<void> moveFile(String originalPath, String newPath) async {
    try {
      File originalFile = File(originalPath);
      Directory destinationDirectory = Directory(newPath).parent;

      // Create the destination directory if it doesn't exist
      if (!await destinationDirectory.exists()) {
        await destinationDirectory.create(recursive: true);
        debugPrint(
            'Destination directory created: ${destinationDirectory.path}');
      }

      // Check if the file exists before attempting to move
      if (await originalFile.exists()) {
        // Use the rename method to move the file
        await originalFile.rename(newPath);
        debugPrint('File moved successfully.');
      } else {
        debugPrint('File does not exist at the original path.');
      }
    } catch (e) {
      debugPrint('Error moving file: $e');
    }
  }

  static Future<void> storeFileInAppDocuments(File file) async {
    final Directory docDir = await getApplicationDocumentsDirectory();
    final String originalPath = file.path;
    final String appDocDirPath = "${docDir.path}\\easy_clip_2_gif\\gifs";
    final String filename = file.path.split('\\').last;

    await moveFile(
      originalPath,
      "$appDocDirPath\\$filename",
    );
  }

  static Future<String?> convertClipToGIF({
    required File file,
    required String name,
    required int framerate,
    required Size resolution,
    required DurationRange range,
  }) async {
    final bool isFFMpegDownloaded = await checkFFMpeg();
    debugPrint("Is downloaded: $isFFMpegDownloaded");

    // Download FFMpeg if it doesn't exists.
    if (!isFFMpegDownloaded) {
      await downloadFFMpeg(
        (progress) {
          debugPrint(
            "Download: ${((progress.fileSize / progress.downloaded) * 100) - 100}%",
          );
        },
      );
    }
    // All GIFs results will first be stored in the temporary items directory.
    // Currently being stored in Temporary Folder.
    final String uniqueFilename = _getUniqueFilename(name);
    final String outputFilepath =
        await _getTemporaryGIFFileOutput(uniqueFilename);

    // Command builder
    // Use prebuilt args and filters or create custom ones
    final FFMpegCommand cliCommand = _createFFmpegCliCommand(
      range: range,
      inputPath: file.path,
      resolution: resolution,
      framerate: framerate,
      outputPath: outputFilepath,
    );

    final File? createdFile = await _runFileCreationCommand(
      cliCommand,
    );

    return createdFile?.path;
  }

  static Future<String> _getTemporaryGIFFileOutput(String filename) async {
    Directory tempDir = await getTemporaryDirectory();

    return path.join(
      tempDir.path,
      "$filename.gif",
    );
  }

  static String _getUniqueFilename(String name) {
    final String curDateTime = DateTime.now().millisecondsSinceEpoch.toString();
    return "${name}_$curDateTime";
  }

  static FFMpegCommand _createFFmpegCliCommand({
    required DurationRange range,
    required int framerate,
    required Size resolution,
    required String inputPath,
    required String outputPath,
  }) {
    return FFMpegCommand(
      inputs: [
        FFMpegInput.asset(
          inputPath,
        ),
      ],
      args: [
        // Cuts the video to the selected time duration.
        TrimArgument(
          start: range.start,
          end: range.end,
        ),

        // Convert video to GIF with determined framerate and resolution, preserving the aspect ratio.
        GifConverterArgument(
          framerate: framerate,
          res: resolution,
        ),

        // If a file with the same output name already exists, it will be overwritten.
        const OverwriteArgument(),
      ],
      outputFilepath: outputPath,
    );
  }

  // Runs file creation through FFMpeg CLI and returns the file path on finish.
  static Future<File?> _runFileCreationCommand(FFMpegCommand cliCommand) {
    Completer<File?> completer = Completer<File?>();

    ffmpeg.runAsync(
      cliCommand,
      onComplete: (outputFile) {
        completer.complete(
          outputFile,
        );
      },
    );

    return completer.future;
  }
}
