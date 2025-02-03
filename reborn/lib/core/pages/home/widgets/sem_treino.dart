import 'package:flutter/material.dart';
import 'package:reborn/core/detalhes_telas/size_tela/size.dart';
import 'package:reborn/core/detalhes_telas/text/text_estilo.dart';

class SemTreino extends StatelessWidget {
  const SemTreino({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.amber,
      child: SizedBox(
        width: context.screenLargura,
        height: 100,
        child: Align(
          alignment: Alignment.center,
          child: Text(
            'Não tem nenhum treino para hoje.',
            style: context.textEstilo.textExtraBold.copyWith(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
