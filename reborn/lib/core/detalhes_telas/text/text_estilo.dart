import 'package:flutter/material.dart';

class TextEstilo {
  static TextEstilo? _instance;
  TextEstilo._();
  static TextEstilo get i {
    _instance ??= TextEstilo._();
    return _instance!;
  }

  String get font => 'mplus1';
  TextStyle get textLight =>
      TextStyle(fontWeight: FontWeight.w300, fontFamily: font);
  TextStyle get textRegular =>
      TextStyle(fontWeight: FontWeight.normal, fontFamily: font);
  TextStyle get textMedium =>
      TextStyle(fontWeight: FontWeight.w500, fontFamily: font);
  TextStyle get textSemiBold =>
      TextStyle(fontWeight: FontWeight.w600, fontFamily: font);
  TextStyle get textBold =>
      TextStyle(fontWeight: FontWeight.bold, fontFamily: font);
  TextStyle get textExtraBold =>
      TextStyle(fontWeight: FontWeight.w800, fontFamily: font);
  TextStyle get textButtonLabel => textBold.copyWith(fontSize: 14);
}

extension TextStylesExtension on BuildContext {
  TextEstilo get textEstilo => TextEstilo.i;
}
