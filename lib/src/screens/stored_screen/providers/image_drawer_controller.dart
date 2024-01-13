import 'package:flutter/material.dart';

class ImageDrawerController extends ChangeNotifier {
  bool _isOpen = false;
  bool get isOpen => _isOpen;

  closeDrawer() {
    _isOpen = false;
    notifyListeners();
  }

  openDrawer() {
    _isOpen = true;
    notifyListeners();
  }
}
