import 'package:asyncstate/asyncstate.dart';
import 'package:barber/src/core/fp/either.dart';
import 'package:barber/src/core/providers/application_provider.dart';
import 'package:barber/src/servers/user_register/user_register_provider_adm.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'user_register_vm.g.dart';

enum UserRegisterStateStatus {
  initial,
  success,
  error,
}

class UserRegisterVm extends _$UserRegisterVm {
  @override
  UserRegisterStateStatus build() => UserRegisterStateStatus.initial;
  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String profile,
  }) async {
    final userRegisterServiceAdm = ref.watch(userRegisterServiceAdmProvider);
    final userData =
        (name: name, emai: email, password: password, profile: 'ADM');
    final registerResult =
        await userRegisterServiceAdm.execute(userData).asyncLoader();
    switch (registerResult) {
      case Success():
        ref.invalidate(getMeProvider);
        state = UserRegisterStateStatus.success;
      case Failure():
        state = UserRegisterStateStatus.error;
    }
  }
}
