import 'package:flutter/material.dart';

class CustomFontes {
  static CustomFontes? _instance;
  CustomFontes._();
  static CustomFontes get i {
    _instance ??= CustomFontes._();
    return _instance!;
  }

  String get font => 'mplus';
  TextStyle get textBoldItalic => TextStyle(fontFamily: font);
  TextStyle get textRegular => TextStyle(fontFamily: font);
  TextStyle get textBold => TextStyle(fontFamily: font);
  TextStyle get textItalic => TextStyle(fontFamily: font);
}

extension TextStylesExtension on BuildContext {
  CustomFontes get cusotomFontes => CustomFontes.i;
}
