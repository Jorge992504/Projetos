import 'package:flutter/material.dart';

import 'package:reborn/core/detalhes_telas/size_tela/size.dart';
import 'package:reborn/core/detalhes_telas/text/text_estilo.dart';

class ExerciciosDiaCard extends StatefulWidget {
  final String nmTreino;
  final String nmExercicio;
  final String descricao;
  const ExerciciosDiaCard(
      {super.key,
      required this.nmTreino,
      required this.nmExercicio,
      required this.descricao});

  @override
  State<ExerciciosDiaCard> createState() => _ExerciciosDiaCard();
}

class _ExerciciosDiaCard extends State<ExerciciosDiaCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      margin: const EdgeInsets.only(left: 20, bottom: 20, right: 20, top: 250),
      //remover-----------------------------------------------------------------------------------------apagar
      // decoration: BoxDecoration(
      //   border: Border.all(
      //     color: Colors.black,
      //     width: 1,
      //   ),
      //   borderRadius: BorderRadius.circular(3),
      //   color: Colors.brown[200],
      // ),
      //ate aqui----------------------------------------------------------------------------------------ate-aqui
      width: context.screenLargura,
      height: 200,
      child: SizedBox(
        width: context.screenLargura,
        height: 200,
        child: Card(
          color: Colors.brown,
          elevation: 10,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  alignment: Alignment.topCenter,
                  //-------------------------------------------------------------------------------------apagar
                  // decoration: BoxDecoration(
                  //   border: Border.all(
                  //     color: Colors.black,
                  //     width: 1,
                  //   ),
                  //   borderRadius: BorderRadius.circular(3),
                  //   color: Colors.brown[200],
                  // ),
                  //---------------------------------------------------------------------------------------ate-aqui
                  width: context.screenMetadeLargura(0.60),
                  height: 25,
                  child: Text(
                    widget.nmTreino,
                    style:
                        context.textEstilo.textExtraBold.copyWith(fontSize: 15),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.only(left: 5, top: 50),
                //-------------------------------------------------------------------------------------apagar
                // decoration: BoxDecoration(
                //   border: Border.all(
                //     color: Colors.black,
                //     width: 1,
                //   ),
                //   borderRadius: BorderRadius.circular(3),
                //   color: Colors.brown[200],
                // ),
                //---------------------------------------------------------------------------------------ate-aqui
                width: context.screenMetadeLargura(0.60),
                height: 25,
                child: Text(
                  widget.nmExercicio,
                  style: context.textEstilo.textBold.copyWith(fontSize: 14),
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.only(left: 5, top: 85),
                //-------------------------------------------------------------------------------------apagar
                // decoration: BoxDecoration(
                //   border: Border.all(
                //     color: Colors.black,
                //     width: 1,
                //   ),
                //   borderRadius: BorderRadius.circular(3),
                //   color: Colors.brown[200],
                // ),
                //---------------------------------------------------------------------------------------ate-aqui
                width: context.screenMetadeLargura(0.85),
                height: 25,
                child: Text(
                  widget.descricao,
                  style: context.textEstilo.textBold.copyWith(fontSize: 14),
                ),
              ),
//------------------------------------------------------------------------------------------------------------------------------
              Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.only(left: 5, top: 120),
                //-------------------------------------------------------------------------------------apagar
                // decoration: BoxDecoration(
                //   border: Border.all(
                //     color: Colors.black,
                //     width: 1,
                //   ),
                //   borderRadius: BorderRadius.circular(3),
                //   color: Colors.brown[200],
                // ),
                //---------------------------------------------------------------------------------------ate-aqui
                width: context.screenMetadeLargura(0.2),
                height: 25,
                child: Text(
                  'Series: 4',
                  style: context.textEstilo.textBold.copyWith(fontSize: 14),
                ),
              ),
//-----------------------------------------------------------------------------------------------------------------------------------------
              Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.only(left: 5, top: 155),
                // //-------------------------------------------------------------------------------------apagar
                // decoration: BoxDecoration(
                //   border: Border.all(
                //     color: Colors.black,
                //     width: 1,
                //   ),
                //   borderRadius: BorderRadius.circular(3),
                //   color: Colors.brown[200],
                // ),
                // //---------------------------------------------------------------------------------------ate-aqui
                width: context.screenMetadeLargura(0.60),
                height: 25,
                child: Text(
                  'Repetições por serie: 12 - 10 - 8 - 8',
                  style: context.textEstilo.textBold.copyWith(fontSize: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
