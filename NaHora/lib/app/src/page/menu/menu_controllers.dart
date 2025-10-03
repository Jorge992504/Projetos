import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:nahora/app/core/exceptions/repository_exception.dart';
import 'package:nahora/app/src/models/produto_model.dart';
import 'package:nahora/app/src/models/request/sacola_model_request.dart';
import 'package:nahora/app/src/page/menu/menu_state.dart';
import 'package:nahora/app/src/repositorio/menu_repository.dart';

class MenuControllers extends Cubit<MenuState> {
  final MenuRepository _repository;
  MenuControllers(this._repository) : super(MenuState.initial());

  Future<void> buscaProdutosEspecificos(
    int menu,
    List<SacolaModelRequest> sacola,
  ) async {
    try {
      emit(
        state.copyWith(
          status: MenuStatus.loading,
          produtosEspecificos: [],
          sacola: sacola,
        ),
      );

      final response = await _repository.buscaProdutosEspecificos(menu);

      emit(
        state.copyWith(
          status: MenuStatus.loaded,
          produtosEspecificos: response,
        ),
      );
    } on RepositoryException catch (e, s) {
      log(
        "ErrorExceptionControllerBuscaProdutosEspecificas: $e \n Stracktrace: $s",
      );
      emit(state.copyWith(status: MenuStatus.failure, produtosEspecificos: []));
    }
  }

  Future<void> buscaPromocoesEspecificas(int menu) async {
    try {
      emit(
        state.copyWith(status: MenuStatus.loading, promocoesEspecificas: []),
      );

      final response = await _repository.buscaPromocoesEspecificas(menu);

      emit(
        state.copyWith(
          status: MenuStatus.loaded,
          promocoesEspecificas: response,
        ),
      );
    } on RepositoryException catch (e, s) {
      log(
        "ErrorExceptionControllerBuscaPromocoesEspecificas: $e \n Stracktrace: $s",
      );
      emit(
        state.copyWith(status: MenuStatus.failure, promocoesEspecificas: []),
      );
    }
  }

  void adicionaProdutoSacola(ProdutoModel produto, int index) {
    try {
      final novaSacola = List<SacolaModelRequest>.from(state.sacola ?? []);

      // procura o produto
      final pos = novaSacola.indexWhere(
        (s) => s.produtoModel!.produtoId == produto.produtoId,
      );

      if (pos != -1) {
        // já existe → incrementa quantidade
        novaSacola[pos].cont = (novaSacola[pos].cont ?? 0) + 1;
      } else {
        // não existe → adiciona novo item
        novaSacola.add(SacolaModelRequest(produtoModel: produto, cont: 1));
      }

      emit(state.copyWith(sacola: novaSacola));
    } catch (e, s) {
      log("Erro ao adicionar produto na sacola: $e \n Stacktrace: $s");
    }
  }

  void removeProdutoSacola(ProdutoModel produto, int index) {
    try {
      final novaSacola = List<SacolaModelRequest>.from(state.sacola ?? []);

      // procura o produto pelo produtoId
      final pos = novaSacola.indexWhere(
        (item) => item.produtoModel?.produtoId == produto.produtoId,
      );

      if (pos != -1) {
        final item = novaSacola[pos];
        final atual = item.cont ?? 0;

        if (atual > 1) {
          // decrementa 1
          item.cont = atual - 1;
        } else {
          // se for 1, remove o item da sacola
          novaSacola.removeAt(pos);
        }

        emit(state.copyWith(sacola: novaSacola));
      }
      // se o produto não existir na sacola, não faz nada
    } catch (e, s) {
      log("Erro ao remover produto da sacola: $e \n Stacktrace: $s");
    }
  }
}
