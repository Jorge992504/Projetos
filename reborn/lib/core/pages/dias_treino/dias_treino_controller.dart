import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reborn/core/erros/exception.dart';
import 'package:reborn/core/modelos/modelo_dias_treino.dart';
import 'package:reborn/core/pages/dias_treino/dias_treino_state.dart';
import 'package:reborn/core/repositorio/dias_treino_repository.dart';

class DiasTreinoController extends Cubit<DiasTreinoState> {
  final DiasTreinoRepository _authDiasTreino;

  DiasTreinoController(this._authDiasTreino) : super(DiasTreinoState.initial());

  Future<void> listarDiasTreinos() async {
    try {
      emit(state.copyWith(status: DiasTreinoStateStatus.loading));
      final dias = await _authDiasTreino.listarDiasTreino();
      ExceptionSuccess(message: 'Dias carregados com successo');
      emit(
        state.copyWith(
          status: DiasTreinoStateStatus.loaded,
          dias: dias,
          diasSelecionado: [],
        ),
      );
    } on DioException catch (e, s) {
      log('Erro ao buscar as doenças,', error: e, stackTrace: s);
      ExceptionErros(message: 'Erro ao buscar as doenças');
      emit(
        state.copyWith(
          status: DiasTreinoStateStatus.error,
        ),
      );
    }
  }

  void selecionarDiasTreino(ModeloDiasTreino dias) {
    var diasSelecionado = state.diasSelecionado;
    var id = diasSelecionado.indexWhere((element) => element.id == dias.id);
    if (id == -1) {
      diasSelecionado.add(dias);
    } else {
      diasSelecionado.removeAt(id);
    }
    emit(state.copyWith(diasSelecionado: diasSelecionado));
  }

  Future<void> relacionarUsuarioDiasTreino() async {
    try {
      emit(
        state.copyWith(status: DiasTreinoStateStatus.register),
      );

      List<int> dias =
          state.diasSelecionado.map<int>((dias) => dias.id).toList();

      await _authDiasTreino.relacionarUsuarioDiasTreino(dias);

      emit(state.copyWith(status: DiasTreinoStateStatus.success));
    } catch (e, s) {
      log('Erro ao relacionar as doenças', error: e, stackTrace: s);
      ExceptionErros(message: 'Erro ao relacionar as doenças');
      emit(state.copyWith(status: DiasTreinoStateStatus.error));
    }
  }
}
