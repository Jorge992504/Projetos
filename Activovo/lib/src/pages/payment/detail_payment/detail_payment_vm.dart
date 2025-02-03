import 'package:activovo/src/funtional_prog/either.dart';
import 'package:activovo/src/pages/payment/detail_payment/detail_payment_state.dart';
import 'package:activovo/src/providers/application_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'detail_payment_vm.g.dart';

@riverpod
class DetailPaymentVm extends _$DetailPaymentVm {
  @override
  DetailPaymentState build() => DetailPaymentState.initial();

  void addOrRemoveImprovements(String improvement) {
    //add ou remove os dias da semana
    final treinoImprovements = state.improvement;
    if (treinoImprovements.contains(improvement)) {
      treinoImprovements.remove(improvement);
    } else {
      treinoImprovements.add(improvement);
    }
    state = state.copyWith(improvement: treinoImprovements);
  }

  bool validar() {
    final treinoImprovements = state.improvement;
    if (treinoImprovements.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  Future<void> registarImprovement() async {
    final repository = ref.watch(userTypeRepositoryProvider);
    final DetailPaymentState(:improvement) = state;

    final dto = (improvement: improvement);
    final registerResult = await repository.savePlanImprovements(dto);

    switch (registerResult) {
      case Success():
        ref.invalidate(getMeUserTypeProvider);
        state = state.copyWith(status: DetailPaymentStateStatus.success);
      case Failure():
        state = state.copyWith(status: DetailPaymentStateStatus.error);
    }
  }
}
