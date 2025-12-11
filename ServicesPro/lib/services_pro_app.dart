import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:servicespro/core/router/rotas.dart';
import 'package:servicespro/core/ui/theme/config_theme.dart';
import 'package:servicespro/src/pages/home_screem.dart';
import 'package:servicespro/src/pages/splash_screen.dart';

class ServicesProApp extends StatelessWidget {
  const ServicesProApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ConfigTheme.lighTheme,
      darkTheme: ConfigTheme.darkTheme,
      themeMode: ThemeMode.system,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('pt', 'BR')],
      routes: {
        Rotas.splash: (context) => SplashScreen(),
        Rotas.home: (context) => HomeScreem(),
      },
    );
  }
}
