import 'package:activovo/src/funtional_prog/either.dart';
import 'package:activovo/src/pages/payment/payment_modify_user_state.dart';
import 'package:activovo/src/providers/application_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'payment_modify_user_vm.g.dart';

@riverpod
class PaymentModifyUserVm extends _$PaymentModifyUserVm {
  @override
  PaymentModifyUserState build() => PaymentModifyUserState.initial();

  Future<void> modifyUser() async {
    final repository = ref.watch(userTypeRepositoryProvider);
    final PaymentModifyUserState(:profile) = state;

    final dto = (profile: profile);
    final registerResult = await repository.modifyUser(dto);

    switch (registerResult) {
      case Success():
        ref.invalidate(getMeUserTypeProvider);
        state = state.copyWith(status: PaymentModifyUserStateStatus.success);
      case Failure():
        state = state.copyWith(status: PaymentModifyUserStateStatus.error);
    }
  }
}
