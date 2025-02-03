import 'package:activovo/src/pages/deteil_exercicio/deteil_exercicio_page.dart';
import 'package:activovo/src/pages/home/home/home_page.dart';
import 'package:activovo/src/pages/home/home_vip/home_vip_page.dart';
import 'package:activovo/src/pages/login/login_page.dart';
import 'package:activovo/src/pages/payment/card_payment/card_payment_page.dart';
import 'package:activovo/src/pages/payment/detail_payment/detail_payment.dart';
import 'package:activovo/src/pages/payment/pix_payment/pix_payment_page.dart';
import 'package:activovo/src/pages/register/user_register_page.dart';
import 'package:activovo/src/pages/splash/splash_pages.dart';
import 'package:activovo/src/pages/splash/splash_valid_payment.dart';
import 'package:activovo/src/pages/training/treinos_com_doenca/user_com_doencas.dart';
import 'package:activovo/src/pages/training/treino_sem_doenca/user_sem_doencas.dart';

import 'package:activovo/src/rotas/rotas.dart';
import 'package:activovo/src/ui/theme/activovo_theme.dart';
import 'package:activovo/src/ui/widgets/activovo_loader.dart';
import 'package:activovo/src/ui/widgets/activovo_nav_global_key.dart';
import 'package:asyncstate/asyncstate.dart';
import 'package:flutter/material.dart';

class ActivovoApp extends StatelessWidget {
  const ActivovoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AsyncStateBuilder(
      customLoader: const ActivovoLoader(),
      builder: (asyncNavigatorObserver) {
        return MaterialApp(
          title: 'Activovô',
          theme: ActivovoTheme.themeData,
          navigatorObservers: [asyncNavigatorObserver],
          navigatorKey: ActivovoNavGlobalKey.instance.navKey,
          routes: {
            Rotas.splash: (context) => const SplashPages(),
            Rotas.login: (context) => const LoginPage(),
            Rotas.home: (context) => const HomePage(),
            Rotas.homeVip: (context) => const HomeVipPage(),
            Rotas.register: (context) => const UserRegisterPage(),
            Rotas.userComDoencas: (context) => const UserComDoencas(),
            Rotas.userSemDoencas: (context) => const UserSemDoencas(),
            Rotas.detailExercicio: (context) => const DeteilExercicioPage(),
            Rotas.detailPayment: (context) => const DetailPaymentPage(),
            Rotas.detailPaymentPix: (context) => const PixPaymentPage(),
            Rotas.detailPaymentCard: (context) => const CardPaymentPage(),
            Rotas.splashValidPayment: (context) => const SplashValidPayment(),
          },
        );
      },
    );
  }
}
