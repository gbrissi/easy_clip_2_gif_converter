import 'package:easy_clip_2_gif/src/constants/text_styles.dart';
import 'package:flutter/material.dart';

class PageDescription extends StatelessWidget {
  const PageDescription({
    super.key,
    required this.title,
    required this.subtitle,
  });
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: TextStyles.title,
        ),
        Text(
          subtitle,
          style: TextStyles.subtitle,
        ),
      ],
    );
  }
}
