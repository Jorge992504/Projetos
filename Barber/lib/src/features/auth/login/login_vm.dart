import 'package:asyncstate/asyncstate.dart';
import 'package:barber/src/core/exceptions/service_exeception.dart';
import 'package:barber/src/core/fp/either.dart';
import 'package:barber/src/core/providers/application_provider.dart';
import 'package:barber/src/features/auth/login/login_state.dart';
import 'package:barber/src/models/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_vm.g.dart';

@riverpod
class LoginVm extends _$LoginVm {
  @override
  LoginState build() => LoginState.initial();

  Future<void> login(String email, String password) async {
    final loaderHandle = AsyncLoaderHandler.start();
    final loginService = ref.watch(userLoginProvider);
    final result = await loginService.execute(email, password);
    switch (result) {
      case Success():
        //!invalidando os caches para evitar o login com usuario errado
        ref.invalidate(getMeProvider);
        ref.invalidate(getMyBarbershopProvider);
        //!buscar dados user
        final userModel = await ref.read(getMeProvider.future);
        switch (userModel) {
          case UserModelADM():
            state = state.copyWith(status: LoginStateStatus.admLogin);
          case UserModelEmployee():
            state = state.copyWith(status: LoginStateStatus.employeeLogin);
        }
        break;
      case Failure(exception: ServiceExeception(:final message)):
        state = state.copyWith(
          status: LoginStateStatus.error,
          errorMessage: () => message,
        );
    }
    loaderHandle.close();
  }
}
