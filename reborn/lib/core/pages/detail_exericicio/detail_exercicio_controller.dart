import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reborn/core/erros/exception.dart';
import 'package:reborn/core/pages/detail_exericicio/detail_exercicio_state.dart';
import 'package:reborn/core/pages/dias_treino/dias_treino_state.dart';
import 'package:reborn/core/repositorio/exercicios_repositorio.dart';

class DetailExercicioController extends Cubit<DetailExercicioState> {
  final ExerciciosRepository _authExercicio;
  DetailExercicioController(this._authExercicio)
      : super(const DetailExercicioState.initial());

  Future<void> listarexercicio() async {
    try {
      emit(state.copyWith(status: DetailExercicioStateStatus.loading));

      ExceptionSuccess(message: 'Dias carregados com successo');
    } on DioException catch (e, s) {
      log('Erro ao buscar as doenças,', error: e, stackTrace: s);
      ExceptionErros(message: 'Erro ao buscar as doenças');
      emit(
        state.copyWith(
          status: DetailExercicioStateStatus.error,
        ),
      );
    }
  }
}
