import 'package:flutter/material.dart';

// Updates Icon and Text widget's colors.
class ColorTheme extends StatefulWidget {
  const ColorTheme({
    super.key,
    required this.color,
    required this.child,
  });
  final Widget child;
  final Color color;

  @override
  State<ColorTheme> createState() => _ColorThemeState();
}

class _ColorThemeState extends State<ColorTheme> {
  ThemeData get _themeContext => Theme.of(context);
  TextTheme get _textTheme => _themeContext.textTheme;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: _themeContext.copyWith(
        iconTheme: _themeContext.iconTheme.copyWith(
          color: widget.color,
        ),
        textTheme: _textTheme.copyWith(
          bodyMedium: _textTheme.bodyMedium!.copyWith(
            color: widget.color,
          ),
        ),
      ),
      child: DefaultTextStyle(
        style: TextStyle(
          color: widget.color,
        ),
        child: widget.child,
      ),
    );
  }
}
