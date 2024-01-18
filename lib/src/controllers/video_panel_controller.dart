import 'dart:io';

import 'package:flutter/material.dart';

class ConvertVideo {
  final File video;
  File? _gif;
  File? get gif => _gif;

  setGif(File? gif) {
    _gif = gif;
  }

  ConvertVideo({
    required this.video,
  });
}

class VideoPanelController extends ChangeNotifier {
  List<ConvertVideo> videos = [];

  void addVid(File file) {
    videos = [...videos, ConvertVideo(video: file)];
    notifyListeners();
  }

  void clearVids() {
    videos = [];
    notifyListeners();
  }

  void removeVid(String filePath) {
    videos = videos.where((e) => e.video.path != filePath).toList();
    notifyListeners();
  }

  void addGifToVid(File video, File gif) {
    final int index = videos.indexWhere((vid) => vid.video.path == video.path);
    videos[index].setGif(gif);
    notifyListeners();
  }
}
