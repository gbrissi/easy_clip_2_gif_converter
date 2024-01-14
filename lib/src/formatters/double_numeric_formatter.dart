import 'package:flutter/services.dart';

final TextInputFormatter doubleNumericFormatter = FilteringTextInputFormatter.allow(
  RegExp(r'[/^(\d+(\.\d+)?)$/]'),
);
