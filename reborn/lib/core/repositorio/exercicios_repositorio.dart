import 'package:reborn/core/modelos/modelo_exercicios.dart';

abstract class ExerciciosRepository {
  Future<List<ModeloExercicio>> findAllExercicios();
}
