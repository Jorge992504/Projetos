import 'package:calculadora/pages/home/home_page.dart';
import 'package:calculadora/pages/splahs/splash_page.dart';
import 'package:calculadora/ui/rotas.dart';
import 'package:calculadora/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:upgrader/upgrader.dart';

class CalculadoraApp extends StatelessWidget {
  const CalculadoraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return UpgradeAlert(
      child: MaterialApp(
        title: 'Calculadora',
        theme: ThemeConfig.theme,
        routes: {
          Rotas.splash: (context) => const SplashPage(),
          Rotas.home: (context) => const HomePage(),
        },
      ),
    );
  }
}
