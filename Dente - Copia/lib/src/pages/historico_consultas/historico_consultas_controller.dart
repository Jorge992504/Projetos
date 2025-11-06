import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:dente/core/exceptions/repository_exception.dart';
import 'package:dente/src/models/response/historico_consultas_response.dart';
import 'package:dente/src/pages/historico_consultas/historico_consultas_state.dart';
import 'package:dente/src/repository/historico_consultas_repository.dart';

class HistoricoConsultasController extends Cubit<HistoricoConsultasState> {
  final HistoricoConsultasRepository _repository;

  HistoricoConsultasController(this._repository)
    : super(HistoricoConsultasState.initial());

  Future<List<HistoricoConsultasResponse>> buscaHistoricoConsultas(
    int pacienteId,
  ) async {
    try {
      emit(state.copyWith(status: HistoricoConsultasStatus.loading));

      final response = await _repository.buscaHistoricoConsultas(pacienteId);

      emit(
        state.copyWith(
          status: HistoricoConsultasStatus.loaded,
          errorMessage: null,
        ),
      );
      return response;
    } on RepositoryException catch (e, s) {
      log('$s');
      emit(
        state.copyWith(
          status: HistoricoConsultasStatus.failure,
          errorMessage: e.message,
        ),
      );
      return [];
    }
  }
}
