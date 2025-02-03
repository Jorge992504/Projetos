import 'package:reborn/core/modelos/modelo_dias_treino.dart';

abstract class TreinoRepository {
  Future<List<ModeloDiasTreino>> listarDiasTreino();
}
