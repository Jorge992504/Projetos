class FormaterValueInverse {
  static int toInt(String text) {
    if (text.isEmpty) return 0;

    return int.parse(
      text.replaceAll('R\$', '').replaceAll('.', '').replaceAll(' ', '').trim(),
    );
  }
}
