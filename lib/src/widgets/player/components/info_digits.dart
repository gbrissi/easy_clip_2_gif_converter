import 'package:easy_clip_2_gif/src/widgets/player/components/digit_text_field.dart';
import 'package:easy_clip_2_gif/src/widgets/player/components/info_label.dart';
import 'package:flutter/material.dart';

class InfoDigits extends StatefulWidget {
  const InfoDigits({
    super.key,
    required this.allowAbsOnly,
    required this.initialValue,
    required this.label,
    this.onChanged,
  });
  final void Function(double value)? onChanged;
  final double initialValue;
  final bool allowAbsOnly;
  final String label;

  @override
  State<InfoDigits> createState() => _InfoDigitsState();
}

class _InfoDigitsState extends State<InfoDigits> {
  String get stringifiedValue => !widget.allowAbsOnly
      ? widget.initialValue.toString()
      : widget.initialValue.toInt().toString();
  
  late final _controller = TextEditingController(
    text: stringifiedValue,
  );

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
              minNumber: 0,
              maxNumber: 60,
              onChanged: widget.onChanged,
              allowAbsOnly: widget.allowAbsOnly,
              controller: _controller,
            ),
          ),
        )
      ],
    );
  }
}
