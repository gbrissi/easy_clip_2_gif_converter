import 'package:easy_clip_2_gif/src/screens/stored_screen/components/stored_files.dart';
import 'package:easy_clip_2_gif/src/widgets/shared/column_separated.dart';
import 'package:flutter/material.dart';

import 'image_file_data.dart';

class StoredFilesSection extends StatefulWidget {
  const StoredFilesSection({
    super.key,
    required this.dateRelatedFiles,
  });
  final DateRelatedFileArray dateRelatedFiles;

  @override
  State<StoredFilesSection> createState() => _StoredFilesSectionState();
}

class _StoredFilesSectionState extends State<StoredFilesSection> {
  @override
  Widget build(BuildContext context) {
    return ColumnSeparated(
      spacing: 4,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.dateRelatedFiles.stringifyDaytime(),
        ),
        Wrap(
          children: widget.dateRelatedFiles.files
              .map(
                (file) => ImageFileData(
                  file: file,
                ),
              )
              .toList(),
        )
      ],
    );
  }
}
