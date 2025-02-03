import 'package:homechat/src/core/fp/either.dart';
import 'package:homechat/src/core/providers/application_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'confirm_vm.g.dart';

enum ConfirmStateStatus {
  initial,
  success,
  error,
}

@riverpod
class ConfirmVm extends _$ConfirmVm {
  @override
  ConfirmStateStatus build() => ConfirmStateStatus.initial;

  Future<void> confirma(int codigo) async {
    final repository = ref.watch(repositoryGeneralProvider);

    final dto = (codigo: codigo);

    final result = await repository.confirmCod(dto);

    switch (result) {
      case Success():
        ref.invalidate(getMeProvider);
        state = ConfirmStateStatus.success;
      case Failure():
        state = ConfirmStateStatus.error;
    }
  }
}
