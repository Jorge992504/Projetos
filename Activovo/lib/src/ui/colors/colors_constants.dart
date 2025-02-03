import 'package:flutter/material.dart';

sealed class ColorsConstants {
  static const greenFundo = Color(0xffb9c9c0);
  static const greyTitulos = Color(0xff797979);
  static const greyEntryF = Color(0xffe7edea);
  static const greyBotoes = Color(0xff3e3e3e);
  static const greyFundoB = Color(0xffd9d9d9);
  static const greyAppBar = Color(0xff94a39a);
  // static const greyAppBar = Color(0xffd9d9d9);
}

class Fontes {
  static Fontes? _instance;
  Fontes._();
  static Fontes get i {
    _instance ??= Fontes._();
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
  Fontes get fontes => Fontes.i;
}

sealed class ImageConstante {
  static const loading = 'assets/images/loading.gif';
  static const logo = 'assets/images/logo.png';
  static const activoco = 'assets/images/activovo.png';
  static const titulo = 'assets/images/titulo.png';
  static const video = 'assets/images/avatar.png';
  static const qrC = 'assets/images/qr.png';
  static const avatar = 'assets/images/avatar.png';
}

extension Size on BuildContext {
  double get WidthScreen => MediaQuery.of(this).size.width;
  double get HeightScreen => MediaQuery.of(this).size.height;
  double WidthScreenM(double percent) => WidthScreen * percent;
  double HeightScreenM(double percet) => HeightScreen * percet;
}
