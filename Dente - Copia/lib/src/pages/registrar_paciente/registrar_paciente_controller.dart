import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dente/core/exceptions/repository_exception.dart';
import 'package:dente/src/models/paciente_model.dart';
import 'package:dente/src/pages/registrar_paciente/registrar_paciente_state.dart';
import 'package:dente/src/repository/registrar_paciente_repository.dart';

class RegistrarPacienteController extends Cubit<RegistrarPacienteState> {
  final RegistrarPacienteRepository _repository;

  RegistrarPacienteController(this._repository)
    : super(RegistrarPacienteState.initial());

  Future<void> registrarPaciente(PacienteModel pacienteModel) async {
    try {
      emit(state.copyWith(status: RegistrarPacienteStatus.loading));

      await _repository.registrarPaciente(pacienteModel);

      emit(
        state.copyWith(
          status: RegistrarPacienteStatus.success,
          errorMessage: null,
        ),
      );
    } on RepositoryException catch (e, s) {
      log('$s');
      emit(
        state.copyWith(
          status: RegistrarPacienteStatus.failure,
          errorMessage: e.message,
        ),
      );
    }
  }

  Future<void> buscarPacientes() async {
    try {
      emit(
        state.copyWith(status: RegistrarPacienteStatus.loading, pacientes: []),
      );

      final response = await _repository.buscarPacientes();

      emit(
        state.copyWith(
          status: RegistrarPacienteStatus.loaded,
          errorMessage: null,
          pacientes: response,
        ),
      );
    } on RepositoryException catch (e, s) {
      log('$s');
      emit(
        state.copyWith(
          status: RegistrarPacienteStatus.failure,
          errorMessage: e.message,
        ),
      );
    }
  }
}
