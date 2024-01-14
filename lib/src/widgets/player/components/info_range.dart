import 'package:easy_clip_2_gif/src/services/gif_converter.dart';
import 'package:easy_clip_2_gif/src/widgets/player/components/info_label.dart';
import 'package:easy_clip_2_gif/src/widgets/shared/duration_text_field.dart';
import 'package:flutter/material.dart';

class InfoRange extends StatefulWidget {
  const InfoRange({
    super.key,
    required this.label,
    required this.maxRange,
    this.onChanged,
  });
  final String label;
  final Duration maxRange;
  final void Function(DurationRange range)? onChanged;

  @override
  State<InfoRange> createState() => _InfoRangeState();
}

class _InfoRangeState extends State<InfoRange> {
  late final ValueNotifier<Duration> _endDuration = ValueNotifier(
    _defaultStartDuration,
  );

  late final ValueNotifier<Duration> _startDuration = ValueNotifier(
    _endInitialDuration,
  );

  Duration get _defaultEndDuration => const Duration(seconds: 10);
  Duration get _defaultStartDuration => Duration.zero;

  Duration get endDuration => _endDuration.value;
  Duration get startDuration => _startDuration.value;

  set endDuration(Duration duration) => _endDuration.value = duration;
  set startDuration(Duration duration) => _startDuration.value = duration;

  Duration get _endInitialDuration => widget.maxRange <= _defaultEndDuration
      ? widget.maxRange
      : _defaultEndDuration;

  @override
  void didUpdateWidget(oldWidget) {
    final int maxRangeMilli = widget.maxRange.inMilliseconds;
    final int oldMaxRangeMilli = oldWidget.maxRange.inMilliseconds;

    bool shouldUpdate = maxRangeMilli != oldMaxRangeMilli;
    if (shouldUpdate && mounted) {
      endDuration = _endInitialDuration;
    }

    super.didUpdateWidget(oldWidget);
  }

  void _triggerOnChangedCallback() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        if (widget.onChanged != null && mounted) {
          final DurationRange range = DurationRange(
            start: startDuration,
            end: endDuration,
          );

          widget.onChanged!(range);
        }
      },
    );
  }

  @override
  void initState() {
    _endDuration.addListener(_triggerOnChangedCallback);
    _startDuration.addListener(_triggerOnChangedCallback);
    super.initState();
  }

  @override
  void dispose() {
    _startDuration.removeListener(_triggerOnChangedCallback);
    _endDuration.removeListener(_triggerOnChangedCallback);
    super.dispose();
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
            child: DurationTextField(
              onChanged: (value) => startDuration = value,
              initialValue: _defaultStartDuration,
              maxDuration: endDuration,
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(4),
          child: Text("-"),
        ),
        Flexible(
          child: IntrinsicWidth(
            child: DurationTextField(
              onChanged: (value) => endDuration = value,
              initialValue: _endInitialDuration,
              minDuration: startDuration,
              maxDuration: widget.maxRange,
            ),
          ),
        ),
      ],
    );
  }
}
