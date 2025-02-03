import 'package:reborn/core/modelos/modelo_dias_treino.dart';
import 'package:reborn/core/modelos/modelo_doenca.dart';

abstract class DoencaRepository {
  Future<void> relacionarUsuarioDoenca(List<int> doencas);
  Future<List<ModeloDoenca>> listarDoenca();
  Future<void> relacionarUsuarioDiasTreino(List<int> dias);

  Future<List<ModeloDiasTreino>> listarDiasTreino();
}
