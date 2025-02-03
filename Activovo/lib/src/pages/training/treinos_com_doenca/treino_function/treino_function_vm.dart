import 'package:activovo/src/funtional_prog/either.dart';
import 'package:activovo/src/pages/training/treinos_com_doenca/treino_function/treino_function_state.dart';
import 'package:activovo/src/providers/application_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'treino_function_vm.g.dart';

@riverpod
class TreinoFunctionVm extends _$TreinoFunctionVm {
  @override
  TreinoFunctionState build() => TreinoFunctionState.initial();

  void addOrRemoveDays(String days) {
    final treinoDays = state.days;
    if (treinoDays.contains(days)) {
      treinoDays.remove(days);
    } else {
      treinoDays.add(days);
    }
    state = state.copyWith(days: treinoDays);
  }

  void addOrRemoveDisease(int disease) {
    final treinoDisease = state.disease;
    if (treinoDisease.contains(disease)) {
      treinoDisease.remove(disease);
    } else {
      treinoDisease.add(disease);
    }
    state = state.copyWith(disease: treinoDisease);
  }

  bool validar() {
    final listDays = state.days;
    // final listDisease = state.disease;
    if (listDays.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  Future<void> registerTreino() async {
    final repository = ref.watch(userTypeRepositoryProvider);

    final TreinoFunctionState(:days, :disease) = state;

    final dto = (
      days: days,
      disease: disease,
    );

    final result = await repository.saveDaysDisease(dto);

    switch (result) {
      case Success():
        ref.invalidate(getMeUserTypeProvider);
        state = state.copyWith(status: TreinoFunctionStateStatus.success);
      case Failure():
        state = state.copyWith(status: TreinoFunctionStateStatus.error);
    }
  }
}
