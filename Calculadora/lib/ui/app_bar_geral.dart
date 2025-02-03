import 'package:flutter/material.dart';

class AppBarGeral extends AppBar {
  AppBarGeral({
    super.key,
    double elevation = 1,
  }) : super(
          elevation: elevation,
          title: Image.asset(
            'assets/imagens/Calculadora.png',
            fit: BoxFit.cover,
            width: 400,
          ),
        );
}
