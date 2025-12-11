import 'package:flutter/material.dart';

extension SizeExtension on BuildContext {
  double get screenWidth =>
      MediaQuery.of(this).size.width; // saber o tamnaho da tela
  double get screenHeight => MediaQuery.of(this).size.height;

  double percentWidth(double percent) =>
      screenWidth * percent; //saber qual e a metade da tela
  double percentHeight(double percent) => screenHeight * percent;
}
