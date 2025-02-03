import 'package:asyncstate/asyncstate.dart';
import 'package:ishopping/core/fp/either.dart';
import 'package:ishopping/core/providers/application_provider.dart';
import 'package:ishopping/src/pages/home/home_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_vm.g.dart';

@riverpod
class HomeVm extends _$HomeVm {
  @override
  Future<HomeState> build() async {
    final repository = ref.read(ishoppingRepositoryProvider);

    final products = await repository.getProducts([]);

    switch (products) {
      case Success(value: final products):
        return HomeState(status: HomeStateStatus.loaded, products: products);
      case Failure():
        return HomeState(status: HomeStateStatus.erro, products: []);
    }
  }

  Future<void> logout() async => ref.read(logoutProvider.future).asyncLoader();
}
