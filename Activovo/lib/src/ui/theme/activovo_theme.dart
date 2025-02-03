import 'package:activovo/src/ui/colors/colors_constants.dart';
import 'package:flutter/material.dart';

sealed class ActivovoTheme {
  static const _defaultInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
    borderSide: BorderSide(color: Colors.grey),
  );
  static ThemeData themeData = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: ColorsConstants.greenFundo,
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      iconTheme: IconThemeData(
        color: ColorsConstants.greyBotoes,
      ),
      backgroundColor: ColorsConstants.greyAppBar,
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 18,
        color: Colors.black,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      labelStyle: const TextStyle(color: Colors.grey),
      border: _defaultInputBorder,
      enabledBorder: _defaultInputBorder,
      focusedBorder: _defaultInputBorder,
      errorBorder: _defaultInputBorder.copyWith(
        borderSide: const BorderSide(color: Colors.red),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: ColorsConstants.greyBotoes,
        backgroundColor: ColorsConstants.greyFundoB,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 0,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        side: const BorderSide(
          color: ColorsConstants.greyFundoB,
          width: 1,
        ),
        foregroundColor: ColorsConstants.greyBotoes,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
  );
}
