import 'package:activovo/src/funtional_prog/either.dart';

import 'package:activovo/src/pages/training/treinos_com_doenca/treino_com_doencas_state.dart';
import 'package:activovo/src/providers/application_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'treino_com_doencas_vm.g.dart';

@riverpod
class TreinoComDoencasVm extends _$TreinoComDoencasVm {
  @override
  Future<TreinoComDoencasState> build() async {
    final repository = ref.read(diseaseRepositoryProvider);

    // final modelDisease = await ref.read(getMeDiseaseProvider.future);

    final diseases = await repository.getDisease();

    switch (diseases) {
      case Success(value: final diseases):
        return TreinoComDoencasState(
            status: TreinoComDoencasStateStatus.loaded, doencas: diseases);
      case Failure():
        return TreinoComDoencasState(
            status: TreinoComDoencasStateStatus.error, doencas: []);
    }
  }
}
