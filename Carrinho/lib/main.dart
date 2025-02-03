import 'dart:io';

import 'package:carrinho/my_http.dart';
import 'package:flutter/material.dart';

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
        theme: ThemeData(
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
          ),
        ),
        routes: const {
          // Rotas.splash: (context) => const SplashPage(),
          // Rotas.login: (context) => LoginRouter.page,
          // Rotas.home: (context) => HomeRouter.page,
          // Rotas.cadastro: (context) => CadastroRouter.page,
          // Rotas.doenca: (context) => DoencaRouter.page,
        },
      ),
    );
  }
}