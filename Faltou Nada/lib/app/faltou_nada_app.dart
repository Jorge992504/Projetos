import 'package:faltou_nada/app/core/providers/application_banding.dart';
import 'package:faltou_nada/app/core/router/rotas.dart';
import 'package:faltou_nada/app/core/ui/theme/config_theme.dart';
import 'package:faltou_nada/app/src/pages/splash_page.dart';
import 'package:flutter/material.dart';

class FaltouNadaApp extends StatelessWidget {
  const FaltouNadaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ApplicationBanding(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ConfigTheme.theme,
        routes: {
          Rotas.splash: (context) => const SplashPage(),
        },
      ),
    );
  }
}
