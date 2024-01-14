import 'package:easy_clip_2_gif/src/services/gif_converter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/gif_config_controller.dart';
import 'info_digits.dart';
import 'info_range.dart';
import 'info_section.dart';
import 'info_size.dart';
import 'info_text.dart';

class GIFConfigSection extends StatefulWidget {
  const GIFConfigSection({
    super.key,
    required this.filename,
    required this.videoDuration,
  });
  final Duration videoDuration;
  final String filename;

  @override
  State<GIFConfigSection> createState() => _GIFConfigSectionState();
}

class _GIFConfigSectionState extends State<GIFConfigSection> {
  late final _gifController = context.read<GIFConfigController>();
  Size get _startSize => const Size(380, 213);

  void _setName(String value) => _gifController.setFilename(value);
  void _setResolution(Size size) => _gifController.setResolution(size);
  void _setFramerate(int framerate) => _gifController.setFramerate(framerate);
  void _setDurationRange(DurationRange durationRange) =>
      _gifController.setDurationRange(
        durationRange,
      );

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _setName(widget.filename),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InfoSection(
      label: "gif convert config",
      children: [
        InfoText.edit(
          label: "name",
          onChanged: _setName,
          text: widget.filename,
        ),
        InfoSize(
          aspectRatio: 16 / 9,
          minSize: _startSize,
          initialSize: _startSize,
          label: "resolution",
          onChanged: _setResolution,
        ),
        InfoDigits(
          initialValue: 10,
          allowAbsOnly: true,
          label: "framerate",
          onChanged: (value) => _setFramerate(value.toInt()),
        ),
        InfoRange(
          label: "duration",
          maxRange: widget.videoDuration,
          onChanged: _setDurationRange,
        )
      ],
    );
  }
}
