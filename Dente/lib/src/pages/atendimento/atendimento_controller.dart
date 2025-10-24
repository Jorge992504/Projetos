import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:dente/core/exceptions/repository_exception.dart';
import 'package:dente/src/pages/atendimento/atendimento_state.dart';
import 'package:dente/src/repository/atendimento_repository.dart';
import 'package:dio/dio.dart';

class AtendimentoController extends Cubit<AtendimentoState> {
  final AtendimentoRepository _repository;

  AtendimentoController(this._repository) : super(AtendimentoState.initial());

  Future<void> terminarAtendimento(FormData formData) async {
    try {
      emit(state.copyWith(status: AtendimentoStatus.loading));

      await _repository.terminarAtendimento(formData);

      emit(
        state.copyWith(status: AtendimentoStatus.loaded, errorMessage: null),
      );
    } on RepositoryException catch (e, s) {
      log('$s');
      emit(
        state.copyWith(
          status: AtendimentoStatus.failure,
          errorMessage: e.message,
        ),
      );
    }
  }
}
