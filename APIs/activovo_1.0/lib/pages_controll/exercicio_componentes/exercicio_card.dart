//import 'package:activovo/pages_controll/exercicio_componentes/exercicio_dia.dart';
//import 'package:activovo/pages_controll/exercicio_componentes/exercicio_dia.dart';
import 'package:activovo/rotas/rotas_pages.dart';
import 'package:flutter/material.dart';

class ExercicioCard extends StatelessWidget {
  final String label;
  final Widget treino1;
  final Widget treino2;
  final Widget treino3;

  const ExercicioCard(
      {super.key,
      required this.label,
      required this.treino1,
      required this.treino2,
      required this.treino3});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(RotasPages.home);
      },
      child: Card(
        color: Colors.green[200],
        elevation: 10,
        child: Container(
          height: 100,
          margin: const EdgeInsets.all(5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      label,
                      style: const TextStyle(fontSize: 15),
                    ),
                  ),
                  treino1,
                  treino2,
                  treino3,
                  const SizedBox(
                    height: 5,
                  )
                ],
              ),
              // const Align(
              //   alignment: Alignment.bottomRight,
              //   child: Text("% 0,00"),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
