import 'package:flutter/services.dart';

extension StringExtension on String {
  String replaceLast(String search, String replace) {
    int lastIndexOfSearch = lastIndexOf(search);

    if (lastIndexOfSearch != -1) {
      // If the search string is found, replace the last occurrence
      return replaceRange(
        lastIndexOfSearch,
        lastIndexOfSearch + search.length,
        replace,
      );
    }

    // If the search string is not found, return the original string
    return this;
  }
}

class NumericRangeFormatter extends TextInputFormatter {
  final double min;
  final double? max;
  final bool isInt;

  NumericRangeFormatter({
    required this.min,
    required this.max,
    required this.isInt,
  });

  String _formatText(String text) {
    if (isInt && text.contains(".")) {
      return text.split(".")[0];
    }

    return text;
  }

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String getReturnValue(String text) {
      String newValue = text;

      if (newValue.isEmpty) {
        newValue = newValue;
        return newValue;
      }

      if (newValue.length == 2 &&
          newValue.startsWith("0") &&
          newValue[1] != ".") {
        newValue = newValue.replaceFirst("0", "");
      }

      if (newValue.startsWith(".")) {
        newValue = newValue.replaceFirst(".", "");
      }

      if (newValue.contains(".")) {
        final List<String> splitText = newValue.split(".");

        for (var i = 0; i < splitText.length; i++) {
          // if (splitText[i].length > 1 && splitText[i].startsWith("0")) {
          //   splitText[i] = splitText[i].replaceFirst("0", "");
          // }

          // If splitText[i] has more than two zero's in sequence, it is not a valid number.
          if (splitText[i].startsWith("00")) {
            splitText[i] = splitText[i].replaceLast("0", "");
          }
        }

        newValue = splitText.join(".");

        // If the "." used for decimal is used more than once
        // The input is not a valid number.
        if (splitText.length > 2) {
          newValue = newValue.replaceLast(".", "");
        }
      }

      final newValueNumber = double.tryParse(
        newValue,
      );

      if (newValueNumber == null) {
        return newValue;
      }

      if (newValueNumber > (max ?? newValueNumber + 1)) {
        return max.toString();
      } else {
        return newValue;
      }
    }

    final String value = _formatText(
      getReturnValue(
        newValue.text,
      ),
    );

    return newValue.copyWith(
      selection: TextSelection.collapsed(offset: value.length),
      text: value,
    );
  }
}
