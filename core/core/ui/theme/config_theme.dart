import 'package:aumigo/core/ui/style/custom_colors.dart';
import 'package:flutter/material.dart';

class ConfigTheme {
  ConfigTheme._();
  static final _defaultInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8.0),
    borderSide: const BorderSide(
      color: ColorsConstants.letraBordas, // Default border color
      width: 1.0,
    ),
  );
  static final theme = ThemeData(
    primaryColor: ColorsConstants.quadro,
    scaffoldBackgroundColor: ColorsConstants.fundoTela,
    appBarTheme: const AppBarTheme(
      backgroundColor: ColorsConstants.appBar,
      titleTextStyle: TextStyle(
        color: ColorsConstants.letraBordas,
        fontSize: 20.0,
      ),
      iconTheme: IconThemeData(
        color: ColorsConstants.letraBordas,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: _defaultInputBorder,
      focusedBorder: _defaultInputBorder.copyWith(
        borderSide: const BorderSide(
          color: ColorsConstants.letraBordas, // Focused border color
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
