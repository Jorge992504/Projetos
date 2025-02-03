import 'package:reborn/core/modelos/modelo_dias_treino.dart';

abstract class DiasTreinoRepository {
  Future<void> relacionarUsuarioDiasTreino(List<int> dias);

  Future<List<ModeloDiasTreino>> listarDiasTreino();
}
