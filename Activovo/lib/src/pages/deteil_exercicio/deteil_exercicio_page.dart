import 'package:activovo/src/models/model_exercise.dart';
import 'package:activovo/src/ui/colors/colors_constants.dart';
import 'package:activovo/src/ui/widgets/header_video_exercicio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeteilExercicioPage extends ConsumerWidget {
  const DeteilExercicioPage({super.key, Object? exercise});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    ModelExercise exer = arguments['exersice'];
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          ImageConstante.titulo,
          width: 130,
        ),
      ),
      body: HeaderVideoExercicio(
        label: exer.description,
        video: exer.video,
        labelSeries: exer.series,
        labelRepetitions: exer.repetitions,
      ),
    );
  }
}
