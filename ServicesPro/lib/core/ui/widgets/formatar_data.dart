import 'package:flutter/services.dart';

class DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = newValue.text.replaceAll(RegExp(r'\D'), '');

    if (digits.length > 8) return oldValue;

    String text = '';

    if (digits.isNotEmpty) {
      text += digits.substring(0, digits.length >= 2 ? 2 : digits.length);
    }

    if (digits.length >= 3) {
      text += '/';
      text += digits.substring(2, digits.length >= 4 ? 4 : digits.length);
    }

    if (digits.length >= 5) {
      text += '/';
      text += digits.substring(4);
    }

    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}
