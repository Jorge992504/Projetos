// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:activovo/src/models/model_exercise.dart';
import 'package:flutter/material.dart';

import 'package:activovo/src/rotas/rotas.dart';
import 'package:activovo/src/ui/colors/colors_constants.dart';

class ExercicioHome extends StatelessWidget {
  final ModelExercise label;
  const ExercicioHome({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 50,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      decoration: BoxDecoration(
        color: ColorsConstants.greyEntryF,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: ColorsConstants.greyFundoB,
        ),
      ),
      child: InkWell(
        onTap: () {
          final exe = label;

          Navigator.of(context)
              .pushNamed(Rotas.detailExercicio, arguments: {'exersice': exe});
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                label.name,
                style: context.fontes.textMedium.copyWith(
                  fontSize: 16,
                  color: ColorsConstants.greyBotoes,
                ),
              ),
            ),
            const Align(
              alignment: Alignment.center,
              child: Icon(
                Icons.play_arrow_rounded,
                color: ColorsConstants.greyBotoes,
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
