import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:dente/core/exceptions/repository_exception.dart';
import 'package:dente/src/models/response/lista_procedimentos_realizados_model.dart';
import 'package:dente/src/pages/relatorio/relatorio_state.dart';
import 'package:dente/src/repository/relatorio_repository.dart';

class RelatorioController extends Cubit<RelatorioState> {
  final RelatorioRepository _repository;

  RelatorioController(this._repository) : super(RelatorioState.initial());

  Future<List<ListaProcedimentosRealizadosModel>?> buscaProcedimentosRealizados(
    String? filtro,
  ) async {
    try {
      emit(state.copyWith(status: RelatorioStatus.loading));

      final response = await _repository.buscaProcedimentosRealizados(filtro);

      emit(state.copyWith(status: RelatorioStatus.loaded));
      return response;
    } on RepositoryException catch (e, s) {
      log('$s');
      emit(
        state.copyWith(
          status: RelatorioStatus.failure,
          errorMessage: e.message,
        ),
      );
      return [];
    }
  }
}
