import 'package:flutter/material.dart';

import 'digit_text_field.dart';
import 'info_label.dart';

class InfoSize extends StatefulWidget {
  const InfoSize({
    super.key,
    this.aspectRatio,
    required this.label,
    required this.initialSize,
    required this.minSize,
    this.onChanged,
  });
  final String label;
  final Size initialSize;
  final Size minSize;
  final double? aspectRatio;
  final void Function(Size size)? onChanged;

  @override
  State<InfoSize> createState() => _InfoSizeState();
}

class _InfoSizeState extends State<InfoSize> {
  bool get preserveAspectRatio => widget.aspectRatio != null;

  late final _startController = TextEditingController(
    text: widget.initialSize.width.toInt().toString(),
  );

  late final _endController = TextEditingController(
    text: widget.initialSize.height.toInt().toString(),
  );

  int? _convertTextToInt(String text) => double.tryParse(text)?.toInt();
  int _getMinNumber(int min, int curNum) => curNum < min ? min : curNum;

  void _postUpdateCallback() {
    final double width = double.parse(_startController.text);
    final double height = double.parse(_endController.text);
    if (widget.onChanged != null) {
      widget.onChanged!(Size(width, height));
    }
  }

  void _updateWidthAspectRatio() {
    final int? height = _convertTextToInt(_endController.text);
    if (height == null) return;
    final int calcWidth = (height * widget.aspectRatio!).ceil();
    final int value = _getMinNumber(widget.minSize.width.toInt(), calcWidth);
    _startController.text = value.toString();
    _postUpdateCallback();
  }

  void _updateHeightAspectRatio() {
    final int? width = _convertTextToInt(_startController.text);
    if (width == null) return;
    final int calcHeight = (width ~/ widget.aspectRatio!).ceil();
    final int value = _getMinNumber(widget.minSize.height.toInt(), calcHeight);
    _endController.text = value.toString();
    _postUpdateCallback();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InfoLabel(
          label: widget.label,
        ),
        Flexible(
          child: IntrinsicWidth(
            child: DigitTextField(
              controller: _startController,
              allowAbsOnly: true,
              onChanged: (_) => _updateHeightAspectRatio(),
              minNumber: widget.minSize.width,
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(4),
          child: Text("x"),
        ),
        Flexible(
          child: IntrinsicWidth(
            child: DigitTextField(
              controller: _endController,
              allowAbsOnly: true,
              onChanged: (_) => _updateWidthAspectRatio(),
              minNumber: widget.minSize.height,
            ),
          ),
        ),
      ],
    );
  }
}
