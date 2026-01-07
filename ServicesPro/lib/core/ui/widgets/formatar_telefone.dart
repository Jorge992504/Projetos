import 'package:flutter/services.dart';

class TelefoneInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = newValue.text.replaceAll(RegExp(r'\D'), '');

    if (digits.length > 11) return oldValue;

    String text = '';

    if (digits.isNotEmpty) {
      text += '(';
      text += digits.substring(0, digits.length >= 2 ? 2 : digits.length);
    }

    if (digits.length >= 3) {
      text += ') ';
      text += digits.substring(2, digits.length >= 7 ? 7 : digits.length);
    }

    if (digits.length >= 8) {
      text += '-';
      text += digits.substring(7);
    }

    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}
