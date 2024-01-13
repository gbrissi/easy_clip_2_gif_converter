import 'dart:io';

import 'package:easy_clip_2_gif/src/screens/stored_screen/components/stored_files_section.dart';
import 'package:easy_clip_2_gif/src/utils/get_day_with_suffix.dart';
import 'package:easy_clip_2_gif/src/utils/get_month_name.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class StoredFiles extends StatefulWidget {
  const StoredFiles({super.key});

  @override
  State<StoredFiles> createState() => _StoredFilesState();
}

class DayTime {
  final int year;
  final int month;
  final int day;

  bool equals(DayTime dayTime) {
    final bool isSameYear = dayTime.year == year;
    final bool isSameMonth = dayTime.month == month;
    final bool isSameDay = dayTime.day == day;

    return isSameDay && isSameMonth && isSameYear;
  }

  DayTime.fromDateTime(DateTime dateTime)
      : year = dateTime.year,
        month = dateTime.month,
        day = dateTime.day;

  DayTime({
    required this.year,
    required this.month,
    required this.day,
  });
}

class DateRelatedFileArray {
  final DayTime dayTime;
  List<File> files = [];

  String stringifyDaytime() {
    final DayTime curDayTime = DayTime.fromDateTime(DateTime.now());

    if (curDayTime.equals(dayTime)) {
      return "Files created today";
    }

    return "Files created in ${getMonthName(dayTime.month)} ${getDayWithSuffix(dayTime.day)}, ${dayTime.year}";
  }

  DateRelatedFileArray({
    required this.dayTime,
    required this.files,
  });
}

List<DateRelatedFileArray> createDRFArrayFromFiles(List<File> files) {
  List<DateRelatedFileArray> dateRelatedFiles = [];

  for (final File file in files) {
    final DayTime fileUpdatedAt = DayTime.fromDateTime(file.lastModifiedSync());
    bool wasDateFoundInArray = false;

    for (DateRelatedFileArray dateRelatedFile in dateRelatedFiles) {
      if (fileUpdatedAt.equals(dateRelatedFile.dayTime)) {
        dateRelatedFile.files.add(file);
        wasDateFoundInArray = true;
        break;
      }
    }

    if (!wasDateFoundInArray) {
      dateRelatedFiles.add(
        DateRelatedFileArray(
          dayTime: fileUpdatedAt,
          files: [file],
        ),
      );
    }
  }

  return dateRelatedFiles;
}

class _StoredFilesState extends State<StoredFiles> {
  List<DateRelatedFileArray> dateRelatedFileArrays = [];

  Future<void> _setStoredFiles() async {
    final Directory docDir = await getApplicationDocumentsDirectory();
    final String appDocDirPath = "${docDir.path}\\easy_clip_2_gif\\gifs";
    final List<FileSystemEntity> dirFiles = Directory(appDocDirPath).listSync();
    final List<File> files = dirFiles.whereType<File>().toList();
    final List<DateRelatedFileArray> drfArrayList =
        createDRFArrayFromFiles(files);

    if (mounted && files.isNotEmpty) {
      setState(() {
        dateRelatedFileArrays = drfArrayList;
      });
    }
  }

  @override
  void initState() {
    // Get stored files from app directory.
    _setStoredFiles();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: dateRelatedFileArrays
          .map(
            (dateRelatedFiles) => StoredFilesSection(
              dateRelatedFiles: dateRelatedFiles,
            ),
          )
          .toList(),
    );
  }
}
