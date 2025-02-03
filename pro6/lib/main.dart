import 'dart:io';

import 'package:activovo/core/providers/application_provider.dart';
import 'package:activovo/my_http.dart';
import 'package:activovo/pages/cadastro_page.dart';
import 'package:activovo/pages/home.dart';
import 'package:activovo/pages/pag_ini.dart';
import 'package:activovo/rotas/rotas_pages.dart';
import 'package:flutter/material.dart';

void main() {
  HttpOverrides.global = MyHttp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ApplicationProvider(
      //chamar tod
      child: MaterialApp(
        title: '',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: false,
        ),
        routes: {
          RotasPages.inicio: (context) => const PagIni(),
          RotasPages.cadastro: (context) => const CadastroPage(),
          RotasPages.home: (context) => const Home(),
        },
      ),
    );
  }
}
