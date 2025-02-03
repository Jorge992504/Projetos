import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reborn/core/pages/detail_exericicio/detail_exercicio_controller.dart';
import 'package:reborn/core/pages/detail_exericicio/detail_exercicio_page.dart';

class DetailExercicioRouter {
  DetailExercicioRouter._();

  static Widget get page => MultiProvider(
        providers: [
          Provider(
            create: (context) => DetailExercicioController(
              context.read(),
            ),
          ),
        ],
        builder: (context, child) {
          final args = ModalRoute.of(context)!.settings.arguments
              as Map<String, dynamic>;
          return DetailExercicioPage(
            exercicio: args['exercicio'],
          );
        },
      );
}
