import 'package:activovo/src/funtional_prog/either.dart';
import 'package:activovo/src/pages/register/user_register_provider.dart';
import 'package:activovo/src/providers/application_provider.dart';
import 'package:asyncstate/asyncstate.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_register_vm.g.dart';

enum UserRegisterStateStatus {
  initial,
  success,
  error,
}

@riverpod
class UserRegisterVm extends _$UserRegisterVm {
  @override
  UserRegisterStateStatus build() => UserRegisterStateStatus.initial;

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
        state = UserRegisterStateStatus.success;

      case Failure():
        state = UserRegisterStateStatus.error;
    }
  }
}
