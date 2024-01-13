import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:ffmpeg_helper/helpers/ffmpeg_helper_class.dart';
import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Necessary initialization for package:media_kit.
  MediaKit.ensureInitialized();

  await FFMpegHelper.instance.initialize();

  runApp(
    const App(),
  );

  doWhenWindowReady(() {
    const initialSize = Size(1080, 607.5);
    appWindow.minSize = const Size(0, 0);
    appWindow.size = initialSize;
    appWindow.alignment = Alignment.center;
    appWindow.show();
  });
}
