import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:nahora/app/core/exceptions/repository_exception.dart';
import 'package:nahora/app/src/models/produto_model.dart';
import 'package:nahora/app/src/models/request/sacola_model_request.dart';
import 'package:nahora/app/src/page/home/home_state.dart';
import 'package:nahora/app/src/repositorio/home_repository.dart';

class HomeController extends Cubit<HomeState> {
  final HomeRepository _repository;
  HomeController(this._repository) : super(HomeState.initial());

  Future<void> buscaPromocoesGerais() async {
    try {
      emit(state.copyWith(status: HomeStatus.loading, promocoesGerais: []));

      final response = await _repository.buscaPromocoesGerais();

      emit(
        state.copyWith(status: HomeStatus.loaded, promocoesGerais: response),
      );
    } on RepositoryException catch (e, s) {
      log(
        "ErrorExceptionControllerBuscaPromocoesGerais: $e \n Stracktrace: $s",
      );
      emit(state.copyWith(status: HomeStatus.failure, promocoesGerais: []));
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
