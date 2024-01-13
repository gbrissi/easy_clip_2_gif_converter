import 'package:easy_clip_2_gif/src/widgets/player/components/digit_text_field.dart';
import 'package:easy_clip_2_gif/src/widgets/player/components/info_label.dart';
import 'package:flutter/material.dart';

class InfoRange extends StatefulWidget {
  const InfoRange({
    super.key,
    required this.label,
    required this.startValue,
    required this.endValue,
    required this.max,
  });
  final String label;
  final double startValue;
  final double endValue;
  final Duration max;

  @override
  State<InfoRange> createState() => _InfoRangeState();
}

// TODO: Duration needs an adapted textfield, can't use digittextfield,
class _InfoRangeState extends State<InfoRange> {
  double get max => widget.max.inMilliseconds / 1000;

  final FocusNode _startFocusNode = FocusNode();
  final FocusNode _endFocusNode = FocusNode();

  late final _startController = TextEditingController(
    text: widget.startValue.toString(),
  );

  late final _endController = TextEditingController(
    text: widget.endValue.toString(),
  );

  @override
  void initState() {
    super.initState();
  }

  void _updateStartRange() {
    final double? _startRange = double.tryParse(_startController.text);
    if (_startRange != null) {
      final double _endRange = double.parse(_endController.text);
      if (_startRange < _endRange) {
        _startController.text =
            "0"; // Temporary initial value (Use state later.)
      }
    }
  }

  void _updateEndRange() {
    final double? _endRange = double.tryParse(_endController.text);
    if (_endRange != null) {
      final double _startRange = double.parse(_startController.text);
      if (_endRange > _startRange) {
        _endController.text =
            max.toString(); // Temporary initial value (Use state later.)
      }
    }
  }

  @override
  void didUpdateWidget(oldWidget) {
    if (oldWidget.startValue != widget.startValue) {
      _startController.text = widget.startValue.toString();
    }
    if (oldWidget.endValue != widget.endValue) {
      _endController.text = widget.endValue.toString();
    }

    super.didUpdateWidget(oldWidget);
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
              onChanged: (_) => _updateStartRange(),
              min: 0,
              max: max,
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(4),
          child: Text("-"),
        ),
        Flexible(
          child: IntrinsicWidth(
            child: DigitTextField(
              onChanged: (_) => _updateEndRange(),
              controller: _endController,
              min: 0,
              max: max,
            ),
          ),
        ),
      ],
    );
  }
}
