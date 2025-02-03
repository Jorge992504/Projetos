import 'package:homechat/src/core/fp/either.dart';
import 'package:homechat/src/core/providers/application_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'invitation_vm.g.dart';

enum InvitationStateStatus {
  initial,
  success,
  error,
}

@riverpod
class InvitationVm extends _$InvitationVm {
  @override
  InvitationStateStatus build() => InvitationStateStatus.initial;

  Future<void> invitation(String email, String text) async {
    final repository = ref.watch(repositoryGeneralProvider);

    final dto = (email: email, text: text);

    final result = await repository.invitation(dto);

    switch (result) {
      case Success():
        ref.invalidate(getMeProvider);
        state = InvitationStateStatus.success;
      case Failure():
        state = InvitationStateStatus.error;
    }
  }
}
