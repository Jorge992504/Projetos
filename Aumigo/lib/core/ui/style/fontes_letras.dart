import 'package:flutter/material.dart';

class FontesLetras {
  static FontesLetras? _instance;
  FontesLetras._();
  static FontesLetras get i {
    _instance ??= FontesLetras._();
    return _instance!;
  }

  String get font => 'mplus';
  TextStyle get textLight =>
      TextStyle(fontWeight: FontWeight.w300, fontFamily: font);
  TextStyle get textRegular =>
      TextStyle(fontWeight: FontWeight.normal, fontFamily: font);
  TextStyle get textThin =>
      TextStyle(fontWeight: FontWeight.w800, fontFamily: font);
  TextStyle get textExtraLight =>
      TextStyle(fontWeight: FontWeight.w500, fontFamily: font);
}

extension TextStylesExtension on BuildContext {
  FontesLetras get fontesLetras => FontesLetras.i;
}
