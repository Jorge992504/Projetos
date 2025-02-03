import 'package:asyncstate/asyncstate.dart';
import 'package:ishopping/core/fp/either.dart';
import 'package:ishopping/core/providers/application_provider.dart';
import 'package:ishopping/src/pages/register/register_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'register_vm.g.dart';

enum RegisterStateStatus {
  initial,
  success,
  error,
}

@riverpod
class RegisterVm extends _$RegisterVm {
  @override
  RegisterStateStatus build() => RegisterStateStatus.initial;

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final userRegisterService = ref.watch(userRegisterServiceProvider);
    final userData = (
      name: name,
      email: email,
      password: password,
    );
    final registerResult =
        await userRegisterService.execute(userData).asyncLoader();
    switch (registerResult) {
      case Success():
        ref.invalidate(getMeProvider);
        state = RegisterStateStatus.success;
      case Failure():
        state = RegisterStateStatus.error;
    }
  }
}
