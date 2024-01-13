import 'package:easy_clip_2_gif/src/widgets/shared/row_separated.dart';
import 'package:flutter/material.dart';

import '../../../constants/text_styles.dart';

class SidebarLogo extends StatelessWidget {
  const SidebarLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return RowSeparated(
      spacing: 8,
      children: [
        // const Icon(
        //   Icons.thumb_up,
        // ),
        Text(
          "EasyClip2Gif",
          style: TextStyles.title,
        ),
      ],
    );
  }
}
