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

      emit(state.copyWith(status: DentistaStatus.success, errorMessage: null));
    } on RepositoryException catch (e, s) {
      log('$s');
      emit(
        state.copyWith(status: DentistaStatus.failure, errorMessage: e.message),
      );
    }
  }

  Future<List<DentistaModel>> buscarDentista() async {
    try {
      emit(state.copyWith(status: DentistaStatus.loading));

      final response = await _repository.buscarDentistas();

      emit(state.copyWith(status: DentistaStatus.loaded, errorMessage: null));
      return response;
    } on RepositoryException catch (e, s) {
      log('$s');
      emit(
        state.copyWith(status: DentistaStatus.failure, errorMessage: e.message),
      );
      return [];
    }
  }

  Future<void> inativarDentistas() async {
    try {
      emit(state.copyWith(status: DentistaStatus.loading));

      final response = await _repository.buscarDentistas();

      emit(state.copyWith(status: DentistaStatus.loaded, errorMessage: null));
    } on RepositoryException catch (e, s) {
      log('$s');
      emit(
        state.copyWith(status: DentistaStatus.failure, errorMessage: e.message),
      );
    }
  }
}
