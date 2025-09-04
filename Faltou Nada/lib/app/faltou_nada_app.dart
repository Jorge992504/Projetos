import 'package:faltou_nada/app/core/providers/application_banding.dart';
import 'package:faltou_nada/app/core/router/rotas.dart';
import 'package:faltou_nada/app/core/ui/theme/config_theme.dart';
import 'package:faltou_nada/app/src/pages/dashboard/dashboard_router.dart';
import 'package:faltou_nada/app/src/pages/home/home_router.dart';
import 'package:faltou_nada/app/src/pages/login/login_router.dart';
import 'package:faltou_nada/app/src/pages/register/register_router.dart';
import 'package:faltou_nada/app/src/pages/splash/splash_page.dart';
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
          Rotas.login: (context) => LoginRouter.page(),
          Rotas.register: (context) => RegisterRouter.page(),
          Rotas.home: (context) => HomeRouter.page(),
          Rotas.dashboard: (context) => DashboardRouter.page(),
        },
      ),
    );
  }
}
