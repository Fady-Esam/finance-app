import 'package:flutter/services.dart';

class AmountInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String newText = newValue.text;

    if (newText.isEmpty) {
      return newValue;
    }

    // Allow only one dot
    if (newText.indexOf('.') != newText.lastIndexOf('.')) {
      return oldValue;
    }

    // Allow only two digits after the dot
    if (newText.contains('.')) {
      int dotIndex = newText.indexOf('.');
      String afterDot = newText.substring(dotIndex + 1);
      if (afterDot.length > 2) {
        return oldValue;
      }
    }

    return newValue;
  }
}
