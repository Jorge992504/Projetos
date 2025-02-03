import 'package:asyncstate/asyncstate.dart';
import 'package:flutter/material.dart';
import 'package:ishopping/core/router/rotas.dart';
import 'package:ishopping/src/pages/home/home_page.dart';
import 'package:ishopping/src/pages/login/login_page.dart';
import 'package:ishopping/src/pages/register/register_page.dart';
import 'package:ishopping/src/pages/splash/splash_page.dart';
import 'package:ishopping/src/ui/theme/ishopping_theme.dart';
import 'package:ishopping/src/ui/widgets/ishopping_nav_global_key.dart';

class IshoppingApp extends StatelessWidget {
  const IshoppingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AsyncStateBuilder(
      // customLoader: ,
      builder: (asyncNavigatorObserver) {
        return MaterialApp(
          title: 'IShopping',
          theme: IshoppingTheme.themeData,
          navigatorObservers: [asyncNavigatorObserver],
          navigatorKey: IshoppingNavGlobalKey.instance.navKey,
          routes: {
            Rotas.splash: (context) => const SplashPage(),
            Rotas.login: (context) => const LoginPage(),
            Rotas.register: (context) => const RegisterPage(),
            Rotas.home: (context) => const HomePage(),
          },
        );
      },
    );
  }
}
