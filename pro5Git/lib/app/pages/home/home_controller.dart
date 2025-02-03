import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:delivery/app/dto/ordem_produto_dto.dart';
import 'package:delivery/app/pages/home/home_state.dart';
import 'package:delivery/app/repositories/products/prod_repo.dart';

class HomeController extends Cubit<HomeState> {
  final ProdRepo _prodRepo;
  HomeController(
    this._prodRepo,
  ) : super(const HomeState.initial());

  Future<void> loadProducts() async {
    emit(state.copyWith(status: HomeStateStatus.loading));
    try {
      final products = await _prodRepo.findAllProducts();
      emit(state.copyWith(
          status: HomeStateStatus.loaded,
          products: products)); //coloca as produtos na tela
    } catch (e, s) {
      log('Erro ao buscar produto', error: e, stackTrace: s);
      emit(
        state.copyWith(
          status: HomeStateStatus.error,
          errorMessage: 'Erro ao buscar produtos',
        ),
      );
    }
  }

//add os itens na lista (sacola)
  void addOrUpdateBag(OrdemProduto retorno) {
    final shoppingBag = [...state.shoppingBag];
    final ordeIndex =
        shoppingBag.indexWhere((produto) => produto.product == retorno.product);
    if (ordeIndex > -1) {
      if (retorno.cont == 0) {
        shoppingBag.removeAt(ordeIndex);
      } else {
        shoppingBag[ordeIndex] = retorno;
      }
    } else {
      shoppingBag.add(retorno);
    }
    emit(state.copyWith(shoppingBag: shoppingBag));
  }
}
