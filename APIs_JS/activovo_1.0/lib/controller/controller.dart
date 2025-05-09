import 'dart:developer';

import 'package:activovo/status/status.dart';
import 'package:bloc/bloc.dart';

//import '../pages_controll/exercicio_componentes/exercicio_reporte.dart';

class Controller extends Cubit<Status> {
  Controller(super.initialState);

  //final ExercicioReporte _exercicioReporte;
  //Controller(this._exercicioReporte) : super(const Status.initial());

  Future<void> loadExercicio() async {
    emit(state.copyWith(status: StateStatus.loading));
    try {
      // final exercicio = await _exercicioReporte.findAllExercicio();
      emit(state.copyWith(status: StateStatus.loaded));
    } catch (e, s) {
      log('Erro ao buscar os exercicios', error: e, stackTrace: s);
      emit(state.copyWith(
          status: StateStatus.error,
          errorMesage: 'Erro ao buscar os exercicios'));
    }
  }
}
