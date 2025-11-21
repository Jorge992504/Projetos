import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dente/core/exceptions/repository_exception.dart';
import 'package:dente/src/models/convenio_model.dart';
import 'package:dente/src/pages/convenio/convenio_state.dart';
import 'package:dente/src/repository/convenio_repository.dart';

class ConvenioController extends Cubit<ConvenioState> {
  final ConvenioRepository _repository;

  ConvenioController(this._repository) : super(ConvenioState.initial());

  Future<void> buscaConvenios() async {
    try {
      emit(state.copyWith(status: ConvenioStatus.loading, convenioModel: []));

      final response = await _repository.buscaConvenios();

      emit(
        state.copyWith(
          status: ConvenioStatus.loaded,
          errorMessage: null,
          convenioModel: response,
        ),
      );
    } on RepositoryException catch (e, s) {
      log('$s');
      emit(
        state.copyWith(
          status: ConvenioStatus.failure,
          errorMessage: e.message,
          convenioModel: [],
        ),
      );
    }
  }

  Future<void> incluirConvenios(ConvenioModel convenioModel) async {
    try {
      emit(state.copyWith(status: ConvenioStatus.loading));

      await _repository.incluirConvenios(convenioModel);

      emit(state.copyWith(status: ConvenioStatus.success, errorMessage: null));
    } on RepositoryException catch (e, s) {
      log('$s');
      emit(
        state.copyWith(status: ConvenioStatus.failure, errorMessage: e.message),
      );
    }
  }

  Future<void> buscaServicos() async {
    try {
      emit(state.copyWith(status: ConvenioStatus.loading, servicosModel: []));

      final response = await _repository.buscaServicos();

      emit(
        state.copyWith(
          status: ConvenioStatus.loaded,
          errorMessage: null,
          servicosModel: response,
        ),
      );
    } on RepositoryException catch (e, s) {
      log('$s');
      emit(
        state.copyWith(
          status: ConvenioStatus.failure,
          errorMessage: e.message,
          servicosModel: [],
        ),
      );
    }
  }
}
