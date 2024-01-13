import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../constants/text_styles.dart';
import '../../../formatters/numeric_range_formatter.dart';

class DigitTextField extends StatefulWidget {
  const DigitTextField({
    super.key,
    required this.controller,
    this.min = 0,
    this.max,
    this.onChanged,
    this.allowAbsOnly = false,
    this.focusNode,
  });
  final void Function(String? text)? onChanged;
  final TextEditingController controller;
  final double min;
  final double? max;
  final bool allowAbsOnly;
  final FocusNode? focusNode;

  @override
  State<DigitTextField> createState() => _DigitTextFieldState();
}

class _DigitTextFieldState extends State<DigitTextField> {
  late final _focusNode = widget.focusNode ?? FocusNode();
  late final String initialValue;

  String _getFormattedNumber(double value) {
    return widget.allowAbsOnly ? value.toInt().toString() : value.toString();
  }

  bool _isNumberInvalid() {
    final String ctrlText = widget.controller.text;

    final newValueNumber = double.tryParse(
      ctrlText,
    );

    if (newValueNumber == null) {
      return true;
    }

    if (newValueNumber < widget.min) {
      final String value = _getFormattedNumber(widget.min);

      widget.controller.text = value;

      if (widget.onChanged != null) {
        widget.onChanged!(value);
      }
    }

    return false;
  }

  @override
  void initState() {
    initialValue = widget.controller.text;
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus && _isNumberInvalid()) {
        widget.controller.text = initialValue;
      }
    });

    super.initState();
  }

  TextInputFormatter get textInputFormatter => !widget.allowAbsOnly
      ? customNumberRegex
      : FilteringTextInputFormatter.digitsOnly;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(999),
      child: Material(
        color: Theme.of(context).canvasColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: TextField(
            onChanged: widget.onChanged,
            controller: widget.controller,
            enableInteractiveSelection: false,
            focusNode: _focusNode,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              textInputFormatter,
              NumericRangeFormatter(
                min: widget.min,
                max: widget.max,
                isInt: widget.allowAbsOnly,
              ),
            ],
            decoration: const InputDecoration(
              isDense: true,
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
              constraints: BoxConstraints(),
            ),
            style: TextStyles.small,
          ),
        ),
      ),
    );
  }
}

final TextInputFormatter customNumberRegex = FilteringTextInputFormatter.allow(
  RegExp(r'[/^(\d+(\.\d+)?)$/]'),
);
