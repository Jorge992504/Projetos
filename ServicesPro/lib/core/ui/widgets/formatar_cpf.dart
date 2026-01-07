import 'package:flutter/services.dart';

class CpfInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = newValue.text.replaceAll(RegExp(r'\D'), '');

    if (digits.length > 11) return oldValue;

    String text = '';

    if (digits.isNotEmpty) {
      text += digits.substring(0, digits.length >= 3 ? 3 : digits.length);
    }

    if (digits.length >= 4) {
      text += '.';
      text += digits.substring(3, digits.length >= 6 ? 6 : digits.length);
    }

    if (digits.length >= 7) {
      text += '.';
      text += digits.substring(6, digits.length >= 9 ? 9 : digits.length);
    }

    if (digits.length >= 10) {
      text += '-';
      text += digits.substring(9);
    }

    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}
