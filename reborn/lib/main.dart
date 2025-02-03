import 'dart:io';

import 'package:flutter/material.dart';

import 'package:reborn/core/custom_dio/env.dart';

import 'package:reborn/core/pages/cadastro/cadastro_router.dart';
import 'package:reborn/core/pages/confir_pagamento/confirmar_pagamento_page.dart';

import 'package:reborn/core/pages/detail_exericicio/detail_exercicio_router.dart';

import 'package:reborn/core/pages/doenca/doenca_router.dart';

import 'package:reborn/core/pages/home/home_router.dart';

import 'package:reborn/core/pages/login/login_router.dart';

import 'package:reborn/core/pages/plano_premium/plano_router.dart';
import 'package:reborn/core/pages/sem_doenca/doenca_router.dart';
import 'package:reborn/core/pages/splash/splash_page.dart';

import 'package:reborn/core/providers/provider.dart';

import 'package:reborn/core/rotas/rotas.dart';
import 'package:reborn/core/ui/theme/theme_config.dart';
import 'package:reborn/my_http.dart';

Future<void> main() async {
  await Env.i.load();
  HttpOverrides.global = MyHttp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderClasse(
      child: MaterialApp(
        title: '',
        theme: ThemeConfig.theme,
        // theme: ThemeData(
        //   useMaterial3: true,
        //   appBarTheme: const AppBarTheme(
        //     iconTheme: IconThemeData(
        //       color: Colors.black,
        //     ),
        //   ),
        // ),
        routes: {
          Rotas.splash: (context) => const SplashPage(),
          Rotas.login: (context) => LoginRouter.page,
          Rotas.home: (context) => HomeRouter.page,
          Rotas.cadastro: (context) => CadastroRouter.page,
          Rotas.doenca: (context) => DoencaRouter.page,
          Rotas.semdoencas: (context) => SemDoencaRouter.page,
          Rotas.detailexercicio: (context) => DetailExercicioRouter.page,
          Rotas.planopremium: (context) => PlanoRouter.page,
          Rotas.confirmarpagamento: (context) => const ConfirmarPagamentoPage(),
        },
      ),
    );
  }
}
