import 'package:flutter/material.dart';
import 'package:reborn/core/detalhes_telas/size_tela/size.dart';
import 'package:reborn/core/detalhes_telas/text/text_estilo.dart';

class DiaSemana extends StatelessWidget {
  final String nome;

  const DiaSemana({super.key, required this.nome});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(top: 9),
      width: context.screenLargura,
      height: 40,
      // decoration: BoxDecoration(
      //   border: Border.all(
      //     color: Colors.blue,
      //     width: 0.6,
      //   ),
      // ),
      child: Text(
        nome,
        style: context.textEstilo.textExtraBold
            .copyWith(fontSize: 20, color: Colors.green[500]),
      ),
    );
  }
}
