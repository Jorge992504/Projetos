import 'package:flutter/material.dart';

class RebornAppBar extends AppBar {
  RebornAppBar({
    super.key,
    double elevation = 1,
    bool automaticallyImplyLeading = true,
  }) : super(
          elevation: elevation,
          automaticallyImplyLeading: automaticallyImplyLeading,
          title: Image.asset(
            'assets/imagens/nome.png',
            width: 100,
            fit: BoxFit.cover,
          ),
        );
}
