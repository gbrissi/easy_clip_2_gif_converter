import 'package:easy_clip_2_gif/src/widgets/shared/row_separated.dart';
import 'package:flutter/material.dart';

class SnackbarConfig {
  final String text;
  final Color color;
  final PressText? pressText;

  SnackbarConfig({
    required this.text,
    required this.color,
    this.pressText,
  });
}

class PressText {
  final String text;
  final void Function() onPressed;

  PressText({
    required this.text,
    required this.onPressed,
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
        content: RowSeparated(
          spacing: 8,
          children: [
            Text(
              config.text,
            ),
            config.pressText != null
                ? InkWell(
                  onTap: config.pressText!.onPressed,
                  child: Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 1,
                        ),
                      ),
                    ),
                    child: Text(
                      config.pressText!.text,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
                : null,
          ].whereType<Widget>().toList(),
        ),
      ),
    );
  }

  static void custom(BuildContext context, {required SnackbarConfig config}) =>
      _showSnackbar(
        context,
        config: config,
      );

  static void failure(
    BuildContext context, {
    required String text,
    PressText? pressText,
  }) =>
      _showSnackbar(
        context,
        config: SnackbarConfig(
          text: text,
          pressText: pressText,
          color: Colors.red,
        ),
      );

  static void success(
    BuildContext context, {
    required String text,
    PressText? pressText,
  }) =>
      _showSnackbar(
        context,
        config: SnackbarConfig(
          text: text,
          pressText: pressText,
          color: Colors.green,
        ),
      );
}
