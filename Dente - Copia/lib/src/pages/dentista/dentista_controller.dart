import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dente/core/exceptions/repository_exception.dart';
import 'package:dente/src/models/dentista_model.dart';
import 'package:dente/src/pages/dentista/dentista_state.dart';
import 'package:dente/src/repository/dentista_repository.dart';

class DentistaController extends Cubit<DentistaState> {
  final DentistaRepository _repository;

  DentistaController(this._repository) : super(DentistaState.initial());

  Future<void> registrarDentista(DentistaModel dentistaModel) async {
    try {
      emit(state.copyWith(status: DentistaStatus.loading));

      await _repository.registrarDentista(dentistaModel);

      final current = state.dentistas ?? [];
      final updatedDentistas = current.map((d) {
        if (d.email == dentistaModel.email) {
          return dentistaModel; // substitui pelo dentista atualizado
        }
        return d;
      }).toList();

      emit(
        state.copyWith(
          status: DentistaStatus.success,
          errorMessage: null,
          dentistas: updatedDentistas,
        ),
      );
    } on RepositoryException catch (e, s) {
      log('$s');
      emit(
        state.copyWith(status: DentistaStatus.failure, errorMessage: e.message),
      );
    }
  }

  Future<void> buscarDentista() async {
    try {
      emit(state.copyWith(status: DentistaStatus.loading));

      final response = await _repository.buscarDentistas();

      emit(
        state.copyWith(
          status: DentistaStatus.loaded,
          errorMessage: null,
          dentistas: response,
        ),
      );
    } on RepositoryException catch (e, s) {
      log('$s');
      emit(
        state.copyWith(status: DentistaStatus.failure, errorMessage: e.message),
      );
    }
  }

  Future<void> inativarAtivarDentistas(String email) async {
    try {
      emit(state.copyWith(status: DentistaStatus.loading));

      final response = await _repository.inativarAtivarDentistas(email);

      final current = state.dentistas ?? [];
      final updatedDentistas = current.map((d) {
        if (d.email == response.email) {
          return response; // substitui pelo dentista atualizado
        }
        return d;
      }).toList();

      emit(
        state.copyWith(
          status: DentistaStatus.loaded,
          errorMessage: null,
          dentistas: updatedDentistas,
        ),
      );
    } on RepositoryException catch (e, s) {
      log('$s');
      emit(
        state.copyWith(status: DentistaStatus.failure, errorMessage: e.message),
      );
    }
  }
}
