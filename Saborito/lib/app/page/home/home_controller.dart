import 'dart:developer';

import 'package:bloc/bloc.dart';

import 'package:saborito/app/dto/order_produto_dto.dart';

import 'package:saborito/app/page/home/home_state.dart';
import 'package:saborito/app/repositories/produtos/produtos_repository.dart';

class HomeController extends Cubit<HomeState> {
  final ProdutosRepository _produtosRepository;
  HomeController(this._produtosRepository)
      : super(
          const HomeState.initial(),
        );

  Future<void> laodedProdutos() async {
    emit(state.copyWith(status: HomeStateStatus.loading));
    try {
      final produtos = await _produtosRepository.listarProdutos();

      emit(state.copyWith(status: HomeStateStatus.loaded, produtos: produtos));
    } catch (e, s) {
      log('Erro ao buscar produtos', error: e, stackTrace: s);
      emit(
        state.copyWith(
            status: HomeStateStatus.error,
            errorMessage: 'Erro ao buscar produtos'),
      );
    }
  }

  void addUpdateBag(OrderProdutoDto orderProdutos) {
    final shoppingBag = [...state.shoppingBag];
    final orderIndex = shoppingBag
        .indexWhere((orderP) => orderP.produtos == orderProdutos.produtos);

    if (orderIndex > -1) {
      shoppingBag[orderIndex] = orderProdutos;
    } else {
      shoppingBag.add(orderProdutos);
    }
    emit(state.copyWith(status: HomeStateStatus.loaded));

    emit(state.copyWith(shoppingBag: shoppingBag));
  }
}
