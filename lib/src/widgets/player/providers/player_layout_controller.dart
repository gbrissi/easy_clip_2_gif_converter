import 'package:flutter/material.dart';

class PlayerTabController extends ChangeNotifier {
  int curIndex = 0;
  late int totalViews = _totalViews.value;
  final ValueNotifier<int> _totalViews;

  @override
  void dispose() {
    _totalViews.removeListener(_updateTotalViews);
    super.dispose();
  }

  void _updateTotalViews() {
    totalViews = _totalViews.value;
    notifyListeners();
  }

  PlayerTabController(this._totalViews) {
    _totalViews.addListener(_updateTotalViews);
  }

  int get maxIndex => _totalViews.value - 1;

  void _setCurIndex(int index) {
    curIndex = index;
    notifyListeners();
  }

  void Function()? get viewPast =>
      curIndex > 0 ? () => _setCurIndex(curIndex - 1) : null;

  void Function()? get viewNext =>
      curIndex < maxIndex ? () => _setCurIndex(curIndex + 1) : null;
}
