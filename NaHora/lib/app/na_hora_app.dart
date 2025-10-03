import 'package:flutter/material.dart';
import 'package:nahora/app/core/providers/application_banding.dart';
import 'package:nahora/app/core/router/rotas.dart';
import 'package:nahora/app/core/ui/theme/config_theme.dart';
import 'package:nahora/app/src/page/home/home_router.dart';
import 'package:nahora/app/src/page/menu/menu_router.dart';
import 'package:nahora/app/src/page/splash/splash_page.dart';

class NaHoraApp extends StatelessWidget {
  const NaHoraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ApplicationBanding(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ConfigTheme.lighTheme,
        darkTheme: ConfigTheme.darkTheme,
        themeMode: ThemeMode.system,
        routes: {
          Rotas.splash: (context) => const SplashPage(),
          Rotas.home: (context) => HomeRouter.page(),
          Rotas.menu: (context) => MenuRouter.page(),
        },
      ),
    );
  }
}
