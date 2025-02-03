import 'package:ishopping/core/fp/either.dart';
import 'package:ishopping/core/providers/application_provider.dart';
import 'package:ishopping/src/pages/home/home_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'list_products.g.dart';

@riverpod
class ListProducts extends _$ListProducts {
  @override
  Future<HomeState> build() async {
    final repository = ref.read(ishoppingRepositoryProvider);

    final product = await repository.getSelectProducts();

    switch (product) {
      case Success(value: final product):
        return HomeState(status: HomeStateStatus.loaded, products: product);
      case Failure():
        return HomeState(status: HomeStateStatus.erro, products: []);
    }
  }

  Future<void> deleteProduct(int id) async {
    final repository = ref.read(ishoppingRepositoryProvider);

    final dto = (id: id);

    final result = await repository.deleteProduct(dto);
    switch (result) {
      case Success():
        break;
      case Failure():
        break;
    }
  }
}
