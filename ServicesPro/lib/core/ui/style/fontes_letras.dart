import 'package:flutter/material.dart';

class CustomFontes {
  static CustomFontes? _instance;
  CustomFontes._();
  static CustomFontes get i {
    _instance ??= CustomFontes._();
    return _instance!;
  }

  String get font => 'mplus';
  TextStyle get thin =>
      TextStyle(fontFamily: font, fontWeight: FontWeight.w100);
  TextStyle get extraLight =>
      TextStyle(fontFamily: font, fontWeight: FontWeight.w200);
  TextStyle get light =>
      TextStyle(fontFamily: font, fontWeight: FontWeight.w300);
  TextStyle get regular =>
      TextStyle(fontFamily: font, fontWeight: FontWeight.w400);
  TextStyle get medium =>
      TextStyle(fontFamily: font, fontWeight: FontWeight.w500);
  TextStyle get semiBold =>
      TextStyle(fontFamily: font, fontWeight: FontWeight.w600);
  TextStyle get bold =>
      TextStyle(fontFamily: font, fontWeight: FontWeight.w700);
  TextStyle get extraBold =>
      TextStyle(fontFamily: font, fontWeight: FontWeight.w800);
  TextStyle get black =>
      TextStyle(fontFamily: font, fontWeight: FontWeight.w900);
}

extension TextStylesExtension on BuildContext {
  CustomFontes get cusotomFontes => CustomFontes.i;
}
