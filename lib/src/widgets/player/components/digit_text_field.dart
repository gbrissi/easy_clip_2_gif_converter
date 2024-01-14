import 'package:easy_clip_2_gif/src/constants/input_decorations.dart';
import 'package:easy_clip_2_gif/src/formatters/double_numeric_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../constants/text_styles.dart';
import '../../../formatters/numeric_range_formatter.dart';

class DigitTextField extends StatefulWidget {
  const DigitTextField({
    super.key,
    required this.controller,
    this.minNumber = 0,
    this.maxNumber,
    this.onChanged,
    this.allowAbsOnly = false,
    this.focusNode,
  });
  final void Function(double number)? onChanged;
  final TextEditingController controller;
  final double minNumber;
  final double? maxNumber;
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

    if (newValueNumber < widget.minNumber) {
      final String value = _getFormattedNumber(widget.minNumber);

      widget.controller.text = value;

      if (widget.onChanged != null) {
        widget.onChanged!(widget.minNumber);
      }
    }

    return false;
  }

  void _triggerOnChangedCallback(String val) {
    final double? curNumber = double.tryParse(val);
    if (widget.onChanged != null && curNumber != null) {
      widget.onChanged!(curNumber);
    }
  }

  void _checkIfNumberIsValid() {
    if (!_focusNode.hasFocus && _isNumberInvalid()) {
      widget.controller.text = initialValue;
      _triggerOnChangedCallback(initialValue);
    }
  }

  @override
  void initState() {
    initialValue = widget.controller.text;
    _focusNode.addListener(_checkIfNumberIsValid);

    super.initState();
  }

  TextInputFormatter get textInputFormatter => !widget.allowAbsOnly
      ? doubleNumericFormatter
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
            onChanged: _triggerOnChangedCallback,
            controller: widget.controller,
            focusNode: _focusNode,
            enableInteractiveSelection: false,
            keyboardType: TextInputType.number,
            decoration: InputDecorations.cardInput,
            style: TextStyles.small,
            inputFormatters: <TextInputFormatter>[
              textInputFormatter,
              NumericRangeFormatter(
                min: widget.minNumber,
                max: widget.maxNumber,
                isInt: widget.allowAbsOnly,
              ),
            ],
          ),
        ),
      ),
    );
  }
}