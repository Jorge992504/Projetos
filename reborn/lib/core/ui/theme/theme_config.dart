import 'package:flutter/material.dart';

class ThemeConfig {
  ThemeConfig._();
  // static final _defaultInputBorder = OutlineInputBorder(
  //   borderRadius: BorderRadius.circular(7),
  //   borderSide: BorderSide(
  //     color: Colors.grey[400]!,
  //   ),
  // );
  static final theme = ThemeData(
    useMaterial3: false,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: Colors.black),
    ),
    primaryColor: const Color.fromARGB(255, 17, 163, 22),
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color.fromARGB(255, 17, 163, 22),
      primary: const Color.fromARGB(255, 17, 163, 22),
      secondary: Colors.amber[400],
    ),
    // inputDecorationTheme: InputDecorationTheme(
    //   fillColor: Colors.white,
    //   filled: true,
    //   isDense: true,
    //   contentPadding: const EdgeInsets.all(13),
    //   border: _defaultInputBorder,
    //   enabledBorder: _defaultInputBorder,
    //   focusedBorder: _defaultInputBorder,
    //   labelStyle: TextEstilo.i.textRegular.copyWith(
    //     color: Colors.black,
    //   ),
    //   errorStyle: TextEstilo.i.textRegular.copyWith(
    //     color: Colors.redAccent,
    //   ),
    // ),
  );
}
