import 'package:reborn/core/modelos/modelo_exercicios.dart';

abstract class HomeRepository {
  Future<List<ModeloExercicio>> listarTreino();
}
