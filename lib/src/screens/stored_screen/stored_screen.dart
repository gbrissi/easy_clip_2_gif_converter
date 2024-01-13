import 'package:easy_clip_2_gif/src/widgets/shared/column_separated.dart';
import 'package:flutter/material.dart';

import '../../widgets/shared/page_description.dart';
import 'components/stored_files.dart';

class StoredScreen extends StatelessWidget {
  const StoredScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ColumnSeparated(
      spacing: 12,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        PageDescription(
          title: "Stored GIFS",
          subtitle: "Check out the GIFS that you have stored in here.",
        ),
        Flexible(
          child: StoredFiles(),
        ),
      ],
    );
  }
}
