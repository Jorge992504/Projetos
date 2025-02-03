import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reborn/core/erros/exception.dart';
import 'package:reborn/core/modelos/modelo_dias_treino.dart';
import 'package:reborn/core/modelos/modelo_doenca.dart';

import 'package:reborn/core/pages/doenca/doenca_state.dart';

import 'package:reborn/core/repositorio/doenca_repository.dart';

class DoencaController extends Cubit<DoencaState> {
  final DoencaRepository _authDoenca;
  // final DiasTreinoRepository _authDiasTreino;

  DoencaController(this._authDoenca) : super(DoencaState.initial());

  Future<void> listarDoencas() async {
    try {
      emit(state.copyWith(status: DoencaStateStatus.loading));
      final doenca = await _authDoenca.listarDoenca();
      ExceptionSuccess(message: 'Doenças carregadas com successo');
      emit(
        state.copyWith(
          status: DoencaStateStatus.loaded,
          doenca: doenca,
          doencaSelecionado: [],
        ),
      );
    } on DioException catch (e, s) {
      log('Erro ao buscar as doenças,', error: e, stackTrace: s);
      ExceptionErros(message: 'Erro ao buscar as doenças');
      emit(
        state.copyWith(
          status: DoencaStateStatus.error,
        ),
      );
    }
  }

  void selecionarDoenca(ModeloDoenca doencaPage) {
    var doencaSelecionado = state.doencaSelecionado;
    var id =
        doencaSelecionado.indexWhere((element) => element.id == doencaPage.id);
    if (id == -1) {
      doencaSelecionado.add(doencaPage);
    } else {
      doencaSelecionado.removeAt(id);
    }
    emit(state.copyWith(doencaSelecionado: doencaSelecionado));
  }

  Future<void> relacionarUsuarioDoenca() async {
    try {
      emit(
        state.copyWith(status: DoencaStateStatus.register),
      );

      List<int> doencas =
          state.doencaSelecionado.map<int>((doenca) => doenca.id).toList();

      await _authDoenca.relacionarUsuarioDoenca(doencas);

      emit(state.copyWith(status: DoencaStateStatus.success));
    } catch (e, s) {
      log('Erro ao relacionar as doenças', error: e, stackTrace: s);
      ExceptionErros(message: 'Erro ao relacionar as doenças');
      emit(state.copyWith(status: DoencaStateStatus.error));
    }
  }
//---------------------------------dias-----------------------------------------

  Future<void> listarDiasTreinos() async {
    try {
      emit(state.copyWith(status: DoencaStateStatus.loading));
      final dias = await _authDoenca.listarDiasTreino();
      ExceptionSuccess(message: 'Doenças carregadas com successo');
      emit(
        state.copyWith(
          status: DoencaStateStatus.loaded,
          dias: dias,
          diasSelecionado: [],
        ),
      );
    } on DioException catch (e, s) {
      log('Erro ao buscar as doenças,', error: e, stackTrace: s);
      ExceptionErros(message: 'Erro ao buscar as doenças');
      emit(
        state.copyWith(
          status: DoencaStateStatus.error,
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
        state.copyWith(status: DoencaStateStatus.register),
      );

      List<int> dias =
          state.diasSelecionado.map<int>((dias) => dias.id).toList();

      await _authDoenca.relacionarUsuarioDiasTreino(dias);

      emit(state.copyWith(status: DoencaStateStatus.success));
    } catch (e, s) {
      log('Erro ao relacionar as doenças', error: e, stackTrace: s);
      ExceptionErros(message: 'Erro ao relacionar as doenças');
      emit(state.copyWith(status: DoencaStateStatus.error));
    }
  }
}
