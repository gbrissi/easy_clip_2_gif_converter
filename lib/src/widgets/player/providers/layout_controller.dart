import 'package:flutter/material.dart';

enum Layout {
  column,
  tab,
}

class LayoutController extends ChangeNotifier {
  Layout layout = Layout.tab;

  void setLayout(Layout newLayout) {
    layout = newLayout;
    notifyListeners();
  }
}
