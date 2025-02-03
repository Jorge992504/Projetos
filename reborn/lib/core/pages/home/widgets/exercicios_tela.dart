import 'package:flutter/material.dart';
import 'package:reborn/core/detalhes_telas/size_tela/size.dart';
import 'package:reborn/core/detalhes_telas/text/text_estilo.dart';
import 'package:reborn/core/modelos/modelo_exercicios.dart';

class ExerciciosTela extends StatelessWidget {
  final ModeloExercicio exe;

  const ExerciciosTela({super.key, required this.exe});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          color: Colors.grey[200],
          child: Stack(
            children: [
              SizedBox(
                width: context.screenLargura,
                height: 25,
                child: Text(
                  exe.nome,
                  style:
                      context.textEstilo.textExtraBold.copyWith(fontSize: 16),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 30),
                width: context.screenLargura,
                height: 25,
                child: Padding(
                  padding: const EdgeInsets.all(0.8),
                  child: Text(
                    exe.descricao,
                    style:
                        context.textEstilo.textSemiBold.copyWith(fontSize: 14),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 60),
                width: context.screenLargura,
                height: 25,
                child: Text(
                  'Series: 4',
                  style: context.textEstilo.textSemiBold.copyWith(fontSize: 14),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 90),
                width: context.screenLargura,
                height: 25,
                child: Text(
                  'Repetições por serie: 12 - 10 - 8 - 8',
                  style: context.textEstilo.textSemiBold.copyWith(fontSize: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
