import 'package:dente/core/providers/application_banding.dart';
import 'package:dente/core/router/rotas.dart';
import 'package:dente/core/ui/theme/config_theme.dart';
import 'package:dente/src/pages/splash/splash_page.dart';
import 'package:flutter/material.dart';

class DenteApp extends StatelessWidget {
  const DenteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ApplicationBanding(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ConfigTheme.lighTheme,
        darkTheme: ConfigTheme.darkTheme,
        themeMode: ThemeMode.system,
        routes: {Rotas.splash: (context) => const SplashPage()},
      ),
    );
  }
}
