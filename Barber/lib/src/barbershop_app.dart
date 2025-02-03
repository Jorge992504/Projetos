import 'package:asyncstate/asyncstate.dart';
import 'package:barber/src/core/ui/theme/barbershop_theme.dart';
import 'package:barber/src/core/ui/widgets/barbershop_loader.dart';
import 'package:barber/src/core/ui/widgets/barbershp_nav_global_key.dart';
import 'package:barber/src/features/auth/login/login_page.dart';
import 'package:barber/src/features/auth/register/barbershop/barbershop_register_page.dart';
import 'package:barber/src/features/auth/register/user/user_register_page.dart';
import 'package:barber/src/features/home/adm/home_adm_page.dart';
import 'package:barber/src/features/splash/splash_page.dart';
import 'package:barber/src/rotas/rotas.dart';
import 'package:flutter/material.dart';

class BarbershopApp extends StatelessWidget {
  const BarbershopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AsyncStateBuilder(
      customLoader: const BarbershopLoader(),
      builder: (asyncNavigatorObserver) {
        return MaterialApp(
          title: 'Barbershop',
          theme: BarbershopTheme.themeData,
          navigatorObservers: [asyncNavigatorObserver],
          navigatorKey: BarbershpNavGlobalKey.instance.navKey,
          routes: {
            Rotas.splash: (context) => const SplashPage(),
            Rotas.login: (context) => const LoginPage(),
            Rotas.userRegister: (context) => const UserRegisterPage(),
            Rotas.registerBarbershop: (context) =>
                const BarbershopRegisterPage(),
            Rotas.adm: (context) => const HomeAdmPage(),
            Rotas.employee: (context) => const Text('Employee'),
          },
        );
      },
    );
  }
}
