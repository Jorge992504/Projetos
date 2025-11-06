import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:dente/core/exceptions/repository_exception.dart';
import 'package:dente/src/models/response/historico_arquivos_response.dart';
import 'package:dente/src/pages/historico_paciente/historico_paciente_state.dart';
import 'package:dente/src/repository/historico_paciente_repository.dart';

class HistoricoPacienteController extends Cubit<HistoricoPacienteState> {
  final HistoricoPacienteRepository _repository;

  HistoricoPacienteController(this._repository)
    : super(HistoricoPacienteState.initial());

  Future<List<HistoricoArquivosResponse>> buscaHistoricoPaciente(
    int pacienteId,
  ) async {
    try {
      emit(state.copyWith(status: HistoricoPacienteStatus.loading));

      final response = await _repository.buscaHistoricoPaciente(pacienteId);

      emit(
        state.copyWith(
          status: HistoricoPacienteStatus.loaded,
          errorMessage: null,
        ),
      );
      return response;
    } on RepositoryException catch (e, s) {
      log('$s');
      emit(
        state.copyWith(
          status: HistoricoPacienteStatus.failure,
          errorMessage: e.message,
        ),
      );
      return [];
    }
  }
}
