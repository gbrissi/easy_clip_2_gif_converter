import 'package:easy_clip_2_gif/src/constants/text_styles.dart';
import 'package:easy_clip_2_gif/src/widgets/shared/column_separated.dart';
import 'package:flutter/material.dart';

class InfoSection extends StatelessWidget {
  const InfoSection({
    super.key,
    required this.label,
    required this.children,
  });
  final List<Widget> children;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: SizedBox(
        width: 320,
        child: ColumnSeparated(
          spacing: 4,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyles.small,
            ),
            ColumnSeparated(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4,
              children: children,
            ),
          ],
        ),
      ),
    );
  }
}
