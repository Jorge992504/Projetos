import 'package:flutter/material.dart';
import 'package:servicespro/core/ui/style/custom_colors.dart';

class ConfigTheme {
  static ThemeData get lighTheme {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: ColorsConstants.primaryColor,
        brightness: Brightness.light, //tema light
        primary: ColorsConstants.primaryColor,
        secondary: ColorsConstants.secundaryColor,
        error: ColorsConstants.errorColor,
        errorContainer: ColorsConstants.errorColor,
      ),

      // AppBar Theme
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: ColorsConstants.primaryColor,
        foregroundColor: ColorsConstants.primaryColor,
        surfaceTintColor: Colors.transparent, // 👈 REMOVE o efeito
        scrolledUnderElevation: 0, // 👈 REMOVE sombra ao scroll
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: ColorsConstants.letrasColor,
        ),
        iconTheme: IconThemeData(color: ColorsConstants.primaryColor),
      ),
      cardTheme: CardThemeData(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: ColorsConstants.azulColor,
      ),
      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorsConstants.azulColor,
          foregroundColor: ColorsConstants.letrasColor,
          elevation: 3,
          shadowColor: ColorsConstants.azulColor.withValues(alpha: 0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          iconColor: ColorsConstants.letrasColor,
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          iconColor: WidgetStateProperty.all(ColorsConstants.letrasColor),
          overlayColor: WidgetStateProperty.all(ColorsConstants.secundaryColor),
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
          borderSide: BorderSide(color: ColorsConstants.letrasColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: ColorsConstants.letrasColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: ColorsConstants.errorColor),
        ),
        labelStyle: TextStyle(
          color: ColorsConstants.letrasColor.withValues(alpha: 0.8),
        ),
        hintStyle: TextStyle(color: ColorsConstants.letrasColor),
        iconColor: ColorsConstants.letrasColor,
      ),
      navigationBarTheme: NavigationBarThemeData(
        height: 60,
        backgroundColor: ColorsConstants.azulColor, // fundo claro
        indicatorColor: ColorsConstants.primaryColor,
        surfaceTintColor: Colors.transparent,

        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return IconThemeData(color: ColorsConstants.azulColor);
          }
          return IconThemeData(color: ColorsConstants.primaryColor);
        }),

        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return TextStyle(
              color: ColorsConstants.primaryColor,
              fontWeight: FontWeight.w900,
              fontFamily: 'mplus',
              fontSize: 12,
            );
          }
          return TextStyle(color: ColorsConstants.primaryColor);
        }),
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
        bodyMedium: TextStyle(fontSize: 14, color: ColorsConstants.letrasColor),
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
        error: ColorsConstants.errorColor,
        errorContainer: ColorsConstants.errorColor,
      ),
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: ColorsConstants.letrasColor,
        foregroundColor: ColorsConstants.primaryColor,
        surfaceTintColor: Colors.transparent, // 👈 REMOVE o efeito
        scrolledUnderElevation: 0, // 👈 REMOVE sombra ao scroll
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: ColorsConstants.primaryColor,
        ),
        iconTheme: IconThemeData(color: ColorsConstants.primaryColor),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorsConstants.azulColor,
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
        color: ColorsConstants.azulColor,
      ),
      scaffoldBackgroundColor: ColorsConstants.letrasColor,
      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          iconColor: WidgetStateProperty.all(ColorsConstants.primaryColor),
          overlayColor: WidgetStateProperty.all(ColorsConstants.primaryColor),
        ),
      ),

      navigationBarTheme: NavigationBarThemeData(
        height: 64,
        backgroundColor: ColorsConstants.azulColor, // fundo escuro
        indicatorColor: ColorsConstants.primaryColor,
        surfaceTintColor: Colors.transparent,

        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return IconThemeData(color: ColorsConstants.azulColor);
          }
          return IconThemeData(color: ColorsConstants.primaryColor);
        }),

        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return TextStyle(
              color: ColorsConstants.primaryColor,
              fontWeight: FontWeight.w600,
            );
          }
          return TextStyle(color: ColorsConstants.primaryColor);
        }),
      ),

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
