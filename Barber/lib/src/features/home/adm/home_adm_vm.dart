import 'package:asyncstate/asyncstate.dart';
import 'package:barber/src/core/fp/either.dart';
import 'package:barber/src/core/providers/application_provider.dart';
import 'package:barber/src/features/home/adm/home_adm_state.dart';
import 'package:barber/src/models/barbershop_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_adm_vm.g.dart';

@riverpod
class HomeAdmVm extends _$HomeAdmVm {
  @override
  Future<HomeAdmState> build() async {
    final repository = ref.read(userRepositoryProvider);
    final BarbershopModel(id: barbershopId) =
        await ref.read(getMyBarbershopProvider.future);
    final employeesResult = await repository.getEmployee(barbershopId);

    switch (employeesResult) {
      case Success(value: final employees):
        return HomeAdmState(
            status: HomeAmdStateStatus.loaded, employee: employees);

      case Failure():
        return HomeAdmState(status: HomeAmdStateStatus.error, employee: []);
    }
  }

  Future<void> logout() => ref.read(logoutProvider.future).asyncLoader();
}
