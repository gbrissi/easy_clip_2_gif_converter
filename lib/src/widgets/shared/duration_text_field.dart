import 'package:easy_clip_2_gif/src/constants/input_decorations.dart';
import 'package:easy_clip_2_gif/src/constants/text_styles.dart';
import 'package:easy_clip_2_gif/src/extensions/time_text_input_formatter.dart';
import 'package:flutter/material.dart';

enum DurationResult {
  minError,
  maxError,
  valid,
}

class DurationTextField extends StatefulWidget {
  const DurationTextField({
    super.key,
    required this.initialValue,
    this.onChanged,
    this.maxDuration,
    this.minDuration,
  });
  final void Function(Duration duration)? onChanged;
  final Duration initialValue;
  final Duration? maxDuration;
  final Duration? minDuration;

  @override
  State<DurationTextField> createState() => _DurationTextFieldState();
}

class _DurationTextFieldState extends State<DurationTextField> {
  final _textFocusNode = FocusNode();

  @override
  void initState() {
    _textFocusNode.addListener(_validateChanges);
    super.initState();
  }

  @override
  void didUpdateWidget(oldWidget) {
    bool shouldUpdate = oldWidget.initialValue.inMilliseconds !=
        widget.initialValue.inMilliseconds;

    if (shouldUpdate && mounted) {
      _textController.text = _formatDuration(
        widget.initialValue,
      );
    }
    super.didUpdateWidget(oldWidget);
  }

  void _validateChanges() {
    if (!_textFocusNode.hasFocus) {
      final Duration duration = _parseDuration(_textController.text);
      DurationResult durationResult = _getDurationResult(duration);

      if (durationResult != DurationResult.valid) {
        if (durationResult == DurationResult.maxError) {
          bool isMinDurationValid = (widget.minDuration?.inMilliseconds ?? 0) <
              widget.initialValue.inMilliseconds;

          bool isInitialValueValid = widget.initialValue.inMilliseconds <
              widget.maxDuration!.inMilliseconds && isMinDurationValid;

          _textController.text = _formatDuration(
            isInitialValueValid ? widget.initialValue : widget.maxDuration!,
          );
        }

        if (durationResult == DurationResult.minError) {
          bool isInitialValueValid = widget.initialValue.inMilliseconds >
              widget.minDuration!.inMilliseconds;

          _textController.text = _formatDuration(
            isInitialValueValid ? widget.initialValue : widget.minDuration!,
          );
        }

        if (widget.onChanged != null) {
          widget.onChanged!(
            duration,
          );
        }
      }
    }
  }

  DurationResult _getDurationResult(Duration duration) {
    if (widget.maxDuration != null) {
      if (duration.inMilliseconds > widget.maxDuration!.inMilliseconds) {
        return DurationResult.maxError;
      }
    }

    if (widget.minDuration != null) {
      if (duration.inMilliseconds < widget.minDuration!.inMilliseconds) {
        return DurationResult.minError;
      }
    }

    return DurationResult.valid;
  }

  late final _textController = TextEditingController(
    text: _formatDuration(
      widget.initialValue,
    ),
  );

  void _filterChanges(String text) {
    final Duration duration = _parseDuration(text);
    bool isValid = _getDurationResult(duration) == DurationResult.valid;

    if (isValid) {
      widget.onChanged!(
        duration,
      );
    }
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));

    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  Duration _parseDuration(String formattedString) {
    List<String> parts = formattedString.split(':');

    if (parts.length != 3) {
      throw const FormatException("Invalid formatted string");
    }

    int hours = int.parse(parts[0]);
    int minutes = int.parse(parts[1]);
    int seconds = int.parse(parts[2]);

    return Duration(
      hours: hours,
      minutes: minutes,
      seconds: seconds,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(999),
      child: Material(
        color: Theme.of(context).canvasColor,
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: TextField(
            focusNode: _textFocusNode,
            controller: _textController,
            onChanged: _filterChanges,
            enableInteractiveSelection: false,
            keyboardType: TextInputType.number,
            decoration: InputDecorations.cardInput,
            style: TextStyles.small,
            inputFormatters: [
              TimeTextInputFormatter(),
            ],
          ),
        ),
      ),
    );
  }
}
