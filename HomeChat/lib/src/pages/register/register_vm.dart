import 'package:asyncstate/asyncstate.dart';
import 'package:homechat/src/core/fp/either.dart';
import 'package:homechat/src/core/providers/application_provider.dart';
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
    final registerService = ref.watch(registerServiceProvider);
    final userData = (
      name: name,
      email: email,
      password: password,
    );
    final registerResult =
        await registerService.execute(userData).asyncLoader();
    switch (registerResult) {
      case Success():
        ref.invalidate(getMeProvider);
        state = RegisterStateStatus.success;
      case Failure():
        state = RegisterStateStatus.error;
    }
  }
}
