import 'package:activovo/src/error/service_exception.dart';
import 'package:activovo/src/funtional_prog/either.dart';
import 'package:activovo/src/pages/login/login_state.dart';
import 'package:activovo/src/providers/application_provider.dart';
import 'package:asyncstate/asyncstate.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_vm.g.dart';

@riverpod
class LoginVm extends _$LoginVm {
  @override
  LoginState build() => LoginState.initial();

  Future<void> login(String email, String password) async {
    final loaderHandle = AsyncLoaderHandler()..start();
    final loginService = ref.watch(userLoginServiceProvider);
    final result = await loginService.execute(email, password);
    switch (result) {
      case Success():
        ref.invalidate(getMeProvider);
        ref.invalidate(getMeUserTypeProvider);
        final userModel = await ref.read(getMeProvider.future);

        switch (userModel.profile) {
          case 'VIP':
            state = state.copyWith(status: LoginStateStatus.vipLogin);
          case 'user':
            state = state.copyWith(status: LoginStateStatus.login);
        }
      case Failure(exception: ServiceException(:final message)):
        state = state.copyWith(
          status: LoginStateStatus.error,
          errorMessage: () => message,
        );
    }
    loaderHandle.close();
  }
}
