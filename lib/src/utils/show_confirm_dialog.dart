import 'package:flutter/material.dart';

showConfirmDialog(
  context, {
  required void Function(bool result) onTap,
  required String title,
  required String description,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(description),
        actions: <Widget>[
          TextButton(
            onPressed: () => onTap(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => onTap(true),
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}
