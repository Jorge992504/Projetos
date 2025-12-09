import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dente/core/exceptions/repository_exception.dart';
import 'package:dente/src/models/paciente_model.dart';
import 'package:dente/src/models/request/novo_agendamento_model_request.dart';
import 'package:dente/src/pages/agendamento/agendamento_state.dart';
import 'package:dente/src/repository/agendamentos_repository.dart';

class AgendamentoController extends Cubit<AgendamentoState> {
  final AgendamentosRepository _repository;

  AgendamentoController(this._repository) : super(AgendamentoState.initial());

  Future<void> criaNovoAgendamento(NovoAgendamentoModelRequest body) async {
    try {
      emit(state.copyWith(status: AgendamentoStatus.loading));

      await _repository.criaNovoAgendamento(body);

      emit(
        state.copyWith(status: AgendamentoStatus.success, errorMessage: null),
      );
    } on RepositoryException catch (e, s) {
      log('$s');
      emit(
        state.copyWith(
          status: AgendamentoStatus.failure,
          errorMessage: e.message,
        ),
      );
    }
  }

  Future<void> buscaDentistasServicos() async {
    try {
      emit(state.copyWith(status: AgendamentoStatus.loading));

      final response = await _repository.buscaDentistasServicos();

      emit(
        state.copyWith(
          status: AgendamentoStatus.loaded,
          errorMessage: null,
          dentistasServicos: response,
        ),
      );
    } on RepositoryException catch (e, s) {
      log('$s');
      emit(
        state.copyWith(
          status: AgendamentoStatus.failure,
          errorMessage: e.message,
        ),
      );
    }
  }

  Future<PacienteModel?> filtraDadosPaciente(String paciente) async {
    try {
      emit(state.copyWith(status: AgendamentoStatus.loading));

      final response = await _repository.filtraDadosPaciente(paciente);

      emit(
        state.copyWith(status: AgendamentoStatus.loaded, errorMessage: null),
      );
      return response;
    } on RepositoryException catch (e, s) {
      log('$s');
      emit(
        state.copyWith(
          status: AgendamentoStatus.failure,
          errorMessage: e.message,
        ),
      );
      return PacienteModel();
    }
  }
}
