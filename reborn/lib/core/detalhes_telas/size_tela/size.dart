import 'package:flutter/material.dart';

extension Size on BuildContext {
  double get screenLargura => MediaQuery.of(this).size.width;
  double get screenAltura => MediaQuery.of(this).size.height;
  double screenMetadeLargura(double percent) => screenLargura * percent;
  double screenMetadeAltura(double percet) => screenAltura * percet;
}
