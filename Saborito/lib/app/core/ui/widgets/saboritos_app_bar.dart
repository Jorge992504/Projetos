import 'package:flutter/material.dart';

class SaboritosAppBar extends AppBar {
  SaboritosAppBar({
    super.key,
    double elevation = 1,
  }) : super(
          elevation: elevation,
          title: Image.asset(
            'assets/imagens/logo.png',
            width: 100,
          ),
        );
}
