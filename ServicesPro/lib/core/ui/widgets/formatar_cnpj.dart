import 'package:flutter/services.dart';

class CnpjInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = newValue.text.replaceAll(RegExp(r'\D'), '');

    if (digits.length > 14) return oldValue;

    String text = '';

    if (digits.isNotEmpty) {
      text += digits.substring(0, digits.length >= 2 ? 2 : digits.length);
    }

    if (digits.length >= 3) {
      text += '.';
      text += digits.substring(2, digits.length >= 5 ? 5 : digits.length);
    }

    if (digits.length >= 6) {
      text += '.';
      text += digits.substring(5, digits.length >= 8 ? 8 : digits.length);
    }

    if (digits.length >= 9) {
      text += '/';
      text += digits.substring(8, digits.length >= 12 ? 12 : digits.length);
    }

    if (digits.length >= 13) {
      text += '-';
      text += digits.substring(12);
    }

    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}
