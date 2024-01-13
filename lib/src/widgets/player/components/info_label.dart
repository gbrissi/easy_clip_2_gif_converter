import 'package:flutter/material.dart';

import '../../../constants/text_styles.dart';

class InfoLabel extends StatelessWidget {
  const InfoLabel({
    super.key,
    required this.label,
  });
  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      "$label: ",
      style: TextStyles.small.copyWith(
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
