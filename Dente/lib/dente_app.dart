import 'package:dente/core/providers/application_banding.dart';
import 'package:dente/core/router/rotas.dart';
import 'package:dente/core/ui/theme/config_theme.dart';
import 'package:dente/src/pages/editar_empresa/editar_empresa_router.dart';
import 'package:dente/src/pages/home/home_page.dart';
import 'package:dente/src/pages/login/login_router.dart';
import 'package:dente/src/pages/registrar_empresa/registrar_empresa_router.dart';
import 'package:dente/src/pages/reset_password/reset_password_router.dart';
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
        routes: {
          Rotas.splash: (context) => const SplashPage(),
          Rotas.login: (context) => LoginRouter.page(),
          Rotas.registrarEmpresa: (context) => RegistrarEmpresaRouter.page(),
          Rotas.resetPassword: (context) => ResetPasswordRouter.page(),
          Rotas.home: (context) => HomePage(),
          Rotas.editarEmpresa: (context) => EditarEmpresaRouter.page(),
        },
      ),
    );
  }
}
