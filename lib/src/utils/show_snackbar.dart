import 'package:flutter/material.dart';

class SnackbarConfig {
  final String text;
  final Color color;

  SnackbarConfig({
    required this.text,
    required this.color,
  });
}

class SnackbarResult {
  static void _showSnackbar(
    BuildContext context, {
    required SnackbarConfig config,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: config.color,
        content: Text(
          config.text,
        ),
      ),
    );
  }

  static void custom(BuildContext context, {required SnackbarConfig config}) =>
      _showSnackbar(
        context,
        config: config,
      );

  static void failure(BuildContext context, {required String text}) =>
      _showSnackbar(
        context,
        config: SnackbarConfig(
          text: text,
          color: Colors.red,
        ),
      );

  static void success(BuildContext context, {required String text}) =>
      _showSnackbar(
        context,
        config: SnackbarConfig(
          text: text,
          color: Colors.green,
        ),
      );
}
