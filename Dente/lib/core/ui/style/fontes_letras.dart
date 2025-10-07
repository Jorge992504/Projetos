import 'package:flutter/material.dart';

class CustomFontes {
  static CustomFontes? _instance;
  CustomFontes._();
  static CustomFontes get i {
    _instance ??= CustomFontes._();
    return _instance!;
  }

  String get font => 'mplus';
  TextStyle get textBoldItalic =>
      TextStyle(fontFamily: font, fontWeight: FontWeight.w500);
  TextStyle get textRegular =>
      TextStyle(fontFamily: font, fontWeight: FontWeight.w300);
  TextStyle get textBold =>
      TextStyle(fontFamily: font, fontWeight: FontWeight.w700);
  TextStyle get textItalic =>
      TextStyle(fontFamily: font, fontWeight: FontWeight.w200);
  TextStyle get textExtraBold =>
      TextStyle(fontFamily: font, fontWeight: FontWeight.w900);
}

extension TextStylesExtension on BuildContext {
  CustomFontes get cusotomFontes => CustomFontes.i;
}
