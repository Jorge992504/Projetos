import 'package:flutter/material.dart';
import 'package:nahora/app/core/ui/style/custom_colors.dart';

class ConfigTheme {
  static ThemeData get lighTheme {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: ColorsConstants.primaryColor,
        brightness: Brightness.light, //tema light
        primary: ColorsConstants.primaryColor,
        secondary: ColorsConstants.secundaryColor,
        error: ColorsConstants.appBarMeatColor,
        errorContainer: ColorsConstants.appBarMeatColor,
      ),

      // AppBar Theme
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: ColorsConstants.appBarColor,
        foregroundColor: ColorsConstants.letrasColor,

        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: ColorsConstants.letrasColor,
        ),
        iconTheme: IconThemeData(color: ColorsConstants.letrasColor),
      ),

      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorsConstants.buttonColor,
          foregroundColor: ColorsConstants.letrasColor,
          elevation: 3,
          shadowColor: ColorsConstants.buttonColor.withValues(alpha: 0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          iconColor: ColorsConstants.letrasColor,
        ),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: ColorsConstants.primaryColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: ColorsConstants.letrasColor.withValues(alpha: 0.3),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: ColorsConstants.primaryColor.withValues(alpha: 0.3),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: ColorsConstants.focusColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: ColorsConstants.appBarMeatColor),
        ),
        labelStyle: TextStyle(
          color: ColorsConstants.letrasColor.withValues(alpha: 0.8),
        ),
        hintStyle: TextStyle(color: ColorsConstants.letrasColor),
        iconColor: ColorsConstants.letrasColor,
      ),

      // Text Theme
      textTheme: TextTheme(
        headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.normal,
          color: ColorsConstants.letrasColor,
        ),
        headlineMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: ColorsConstants.letrasColor,
        ),
        titleLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: ColorsConstants.letrasColor,
        ),
        titleMedium: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: ColorsConstants.letrasColor,
        ),
        bodyLarge: TextStyle(fontSize: 16, color: ColorsConstants.letrasColor),
        bodyMedium: TextStyle(fontSize: 14, color: ColorsConstants.focusColor),
      ),

      iconTheme: IconThemeData(color: ColorsConstants.letrasColor, size: 24),

      scaffoldBackgroundColor: ColorsConstants.primaryColor,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: ColorsConstants.primaryColor,
        brightness: Brightness.dark,
        primary: ColorsConstants.primaryColor,
        secondary: ColorsConstants.secundaryColor,
        error: ColorsConstants.appBarMeatColor,
        errorContainer: ColorsConstants.appBarMeatColor,
      ),
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: ColorsConstants.appBarColor,
        foregroundColor: ColorsConstants.primaryColor,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: ColorsConstants.primaryColor,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorsConstants.buttonColor,
          foregroundColor: ColorsConstants.primaryColor,
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: ColorsConstants.cardColor,
      ),
      scaffoldBackgroundColor: ColorsConstants.letrasColor,

      // Text Theme
      textTheme: TextTheme(
        headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.normal,
          color: ColorsConstants.primaryColor,
        ),
        headlineMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: ColorsConstants.primaryColor,
        ),
        titleLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: ColorsConstants.primaryColor,
        ),
        titleMedium: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: ColorsConstants.primaryColor,
        ),
        bodyLarge: TextStyle(fontSize: 16, color: ColorsConstants.primaryColor),
        bodyMedium: TextStyle(
          fontSize: 14,
          color: ColorsConstants.primaryColor,
        ),
      ),
    );
  }
}
