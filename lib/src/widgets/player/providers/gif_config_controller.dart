import 'package:easy_clip_2_gif/src/services/gif_converter.dart';
import 'package:flutter/material.dart';

class GIFConfigController extends ChangeNotifier {
  int _framerate = 10;
  Size _resolution = const Size(380, 213);
  String _filename = "named_file";
  DurationRange _durationRange = DurationRange(
    start: Duration.zero,
    end: Duration.zero,
  );

  int get framerate => _framerate;
  Size get resolution => _resolution;
  String get filename => _filename;
  DurationRange get durationRange => _durationRange;

  setFramerate(int framerate) {
    _framerate = framerate;
    notifyListeners();
  }

  setResolution(Size resolution) {
    _resolution = resolution;
    notifyListeners();
  }

  setFilename(String filename) {
    _filename = filename;
    notifyListeners();
  }

  setDurationRange(DurationRange range) {
    _durationRange = range;
    notifyListeners();
  }
}
