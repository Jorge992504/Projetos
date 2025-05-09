//import 'package:activovo/rotas/rotas_pages.dart';
//pagina com o conteudo do treino
//import 'package:activovo/pages_controll/home_componentes/home_exercicio.dart';
//import 'package:activovo/rotas/rotas_pages.dart';
//import 'package:activovo/size_tela/size_extensions.dart';
//import 'package:activovo/controller/controller.dart';
//import 'package:activovo/pages_controll/exercicio_componentes/exercicio_card.dart';
import 'package:activovo/pages_controll/home_componentes/home_exercicio.dart';
//import 'package:activovo/pages_controll/home_componentes/home_exercicio.dart';
//import 'package:activovo/status/status.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/widgets.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green[200],
        ),
        body: const HomeExercicio());

    // floatingActionButton: FloatingActionButton(
    //   onPressed: () {
    //     Navigator.of(context).popAndPushNamed(RotasPages.exercicio);
    //   },
    // ),
  }
}
