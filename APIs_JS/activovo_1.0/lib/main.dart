import 'dart:io';

import 'package:activovo/core/providers/application_provider.dart';
import 'package:activovo/core/providers/auth_provider.dart';
import 'package:activovo/my_http.dart';
import 'package:activovo/pages_controll/cadastro_page.dart';
import 'package:activovo/pages_controll/exercicio_componentes/escolher_plano_exercicio.dart';
import 'package:activovo/pages_controll/exercicio_page.dart';
//import 'package:activovo/pages_controll/exercicio_page.dart';
import 'package:activovo/pages_controll/home.dart';
//import 'package:activovo/pages_controll/home_componentes/home_exercicio.dart';
//import 'package:activovo/pages_controll/home.dart';
import 'package:activovo/pages_controll/pag_ini.dart';
import 'package:activovo/pages_controll/perfil_page.dart';
import 'package:activovo/rotas/rotas_pages.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
          useMaterial3: false,
          appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
          ),
        ),
        routes: {
          RotasPages.inicio: (context) => const PagIni(),
          RotasPages.cadastro: (context) => const CadastroPage(),
          RotasPages.home: (context) => const Home(),
          RotasPages.exercicio: (context) => ExercicioPage(
                usuario: Provider.of<AuthProvider>(context).usuario!,
              ),
          RotasPages.perfil: (context) => PerfilPage(
                user: Provider.of<AuthProvider>(context).usuario,
              ),
          RotasPages.plano: (context) => const EscolherPlano(),
        },
      ),
    );
  }
}
