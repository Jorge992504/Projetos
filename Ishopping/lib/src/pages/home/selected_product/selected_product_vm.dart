import 'package:ishopping/core/fp/either.dart';
import 'package:ishopping/core/providers/application_provider.dart';
import 'package:ishopping/src/pages/home/selected_product/selected_product_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'selected_product_vm.g.dart';

@riverpod
class SelectedProductVm extends _$SelectedProductVm {
  @override
  SelectedProductState build() => SelectedProductState.initial();

  Future<void> postProduct(int id) async {
    final repository = ref.watch(ishoppingRepositoryProvider);

    // final SelectedProductState(:idProduct) = state;

    final dto = (idProducts: id,);

    final result = await repository.postProducts(dto);

    switch (result) {
      case Success():
        ref.invalidate(getMeProductsProvider);
        state = state.copyWith(status: SelectedProductStateStatus.success);
      case Failure():
        state = state.copyWith(status: SelectedProductStateStatus.error);
    }
  }

  Future<void> postNewProduct(String name) async {
    final repository = ref.watch(ishoppingRepositoryProvider);

    final dto = (name: name);

    final result = await repository.postNewProduct(dto);

    switch (result) {
      case Success():
        ref.invalidate(getMeProductsProvider);
        state = state.copyWith(status: SelectedProductStateStatus.success);
      case Failure():
        state = state.copyWith(status: SelectedProductStateStatus.error);
    }
  }
}
