import 'package:flutter/material.dart';
import 'package:ishopping/src/ui/colors/colors_constants.dart';

sealed class IshoppingTheme {
  static const _defaultInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
    borderSide: BorderSide(color: Colors.grey),
  );
  static ThemeData themeData = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: ColorsConstants.fundo,
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      iconTheme: IconThemeData(
        color: ColorsConstants.label,
      ),
      backgroundColor: ColorsConstants.title,
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
        foregroundColor: ColorsConstants.title,
        backgroundColor: ColorsConstants.button,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 0,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        side: const BorderSide(
          color: ColorsConstants.fundo,
          width: 1,
        ),
        foregroundColor: ColorsConstants.title,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
  );
}
