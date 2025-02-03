import 'package:asyncstate/asyncstate.dart';
import 'package:ishopping/core/errors/service_exception.dart';
import 'package:ishopping/core/fp/either.dart';
import 'package:ishopping/core/providers/application_provider.dart';
import 'package:ishopping/src/pages/login/login_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_vm.g.dart';

@riverpod
class LoginVm extends _$LoginVm {
  @override
  LoginState build() => LoginState.initial();

  Future<void> login(String email, String password) async {
    final loaderHandle = AsyncLoaderHandler.start();
    final loginService = ref.watch(userLoginServiceProvider);
    final result = await loginService.execute(email, password);
    switch (result) {
      case Success():
        ref.invalidate(getMeProvider);
        ref.invalidate(getMeProductsProvider);

        state = state.copyWith(status: LoginStateStatus.login);
      case Failure(exception: ServiceException(:final message)):
        state = state.copyWith(
          status: LoginStateStatus.error,
          errorMessage: message,
        );
    }
    loaderHandle.close();
  }
}
