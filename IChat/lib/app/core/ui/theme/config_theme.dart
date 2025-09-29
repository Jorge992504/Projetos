import 'package:flutter/material.dart';
import 'package:ichat/app/core/ui/style/custom_colors.dart';

class ConfigTheme {
  ConfigTheme._();
  static final _defaultInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8.0),
    borderSide: const BorderSide(
      color: ColorsConstants.buttonBordas, // Default border color
      width: 1.0,
    ),
  );
  static final theme = ThemeData(
    useMaterial3: true,
    primaryColor: ColorsConstants.buttonBordas,
    scaffoldBackgroundColor: ColorsConstants.fundo,
    canvasColor: ColorsConstants.fundo,
    appBarTheme: const AppBarTheme(
      backgroundColor: ColorsConstants.appBar,
      titleTextStyle: TextStyle(color: ColorsConstants.textos, fontSize: 20.0),
      iconTheme: IconThemeData(color: ColorsConstants.textos),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: _defaultInputBorder,
      focusedBorder: _defaultInputBorder.copyWith(
        borderSide: const BorderSide(
          color: ColorsConstants.buttonBordas, // Focused border color
          width: 2.0,
        ),
      ),
      enabledBorder: _defaultInputBorder,
      errorBorder: _defaultInputBorder.copyWith(
        borderSide: const BorderSide(
          color: Colors.red, // Error border color
          width: 1.0,
        ),
      ),
    ),
  );
}
