import 'package:activovo/src/funtional_prog/either.dart';
import 'package:activovo/src/pages/training/treino_sem_doenca/treino_sem_doencas_state.dart';
import 'package:activovo/src/providers/application_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'treino_sem_doencas_vm.g.dart';

@riverpod
class TreinoSemDoencasVm extends _$TreinoSemDoencasVm {
  @override
  TreinoSemDoencasState build() => TreinoSemDoencasState.initial();

  void addOrRemoveDays(String days) {
    //add ou remove os dias da semana
    final treinoDays = state.days;
    if (treinoDays.contains(days)) {
      treinoDays.remove(days);
    } else {
      treinoDays.add(days);
    }
    state = state.copyWith(days: treinoDays);
  }

  bool validar() {
    final listDays = state.days;
    if (listDays.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  Future<void> registarTreino() async {
    final repository = ref.watch(userTypeRepositoryProvider);
    final TreinoSemDoencasState(:days) = state;

    final dto = (days: days);
    final registerResult = await repository.saveDays(dto);

    switch (registerResult) {
      case Success():
        ref.invalidate(getMeUserTypeProvider);
        state = state.copyWith(status: TreinoSemDoencasStateStatus.success);
      case Failure():
        state = state.copyWith(status: TreinoSemDoencasStateStatus.error);
    }
  }
}
