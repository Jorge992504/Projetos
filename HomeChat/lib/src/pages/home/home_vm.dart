import 'package:asyncstate/asyncstate.dart';
import 'package:homechat/src/core/fp/either.dart';
import 'package:homechat/src/core/providers/application_provider.dart';
import 'package:homechat/src/pages/home/home_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_vm.g.dart';

@riverpod
class HomeVm extends _$HomeVm {
  @override
  Future<HomeState> build() async {
    final repository = ref.read(repositoryGeneralProvider);
    final users = await repository.getUsers([]);
    switch (users) {
      case Success(value: final user):
        return HomeState(status: HomeStateStatus.loaded, users: user);
      case Failure():
        return HomeState(status: HomeStateStatus.error, users: []);
    }
  }

  Future<void> addFriends(int userId) async {
    final repository = ref.read(repositoryGeneralProvider);
    final dto = (userId: userId);
    final result = await repository.addRequest(dto);
    switch (result) {
      case Success():
        ref.invalidate(getMeProvider);
        ref.invalidate(repositoryGeneralProvider);

      case Failure():
        state = HomeStateStatus.error as AsyncValue<HomeState>;
    }
  }

  Future<void> logout() async => ref.read(logoutProvider.future).asyncLoader();
}
