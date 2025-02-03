// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reborn/core/erros/exception.dart';

import 'package:reborn/core/implementacoes_interfaz/treino_repository_impl.dart';
import 'package:reborn/core/pages/treino/treino_state.dart';

class TreinoController extends Cubit<TreinoState> {
  final TreinoRepositoryImpl _authTreino;
  TreinoController(
    this._authTreino,
  ) : super(const TreinoState.initial());

  Future<void> criarTreino() async {
    try {
      emit(
        state.copyWith(status: TreinoStateStatus.register),
      );

      await _authTreino.criarTreino();
      emit(
        state.copyWith(status: TreinoStateStatus.success),
      );
      ExceptionSuccess(message: 'Treino criado com successo');
    } on DioException catch (e, s) {
      log('Erro ao criar o treino,', error: e, stackTrace: s);
      ExceptionErros(message: 'Erro ao criar o treino');
      emit(
        state.copyWith(
          status: TreinoStateStatus.error,
        ),
      );
    }
  }
}
