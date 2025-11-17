import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:dente/core/exceptions/repository_exception.dart';
import 'package:dente/src/pages/dashboard/dashboard_state.dart';
import 'package:dente/src/repository/dashboard_repository.dart';

class DashboardController extends Cubit<DashboardState> {
  final DashboardRepository _repository;

  DashboardController(this._repository) : super(DashboardState.initial());

  Future<void> buscaProcedimentosRealizados(String? filtro) async {
    try {
      emit(
        state.copyWith(
          status: DashboardStatus.loading,
          procedimentosRealizados: [],
        ),
      );

      final response = await _repository.buscaProcedimentosRealizados(filtro);

      emit(
        state.copyWith(
          status: DashboardStatus.loaded,
          procedimentosRealizados: response,
        ),
      );
    } on RepositoryException catch (e, s) {
      log('$s');
      emit(
        state.copyWith(
          status: DashboardStatus.failure,
          errorMessage: e.message,
          procedimentosRealizados: [],
        ),
      );
    }
  }

  Future<void> buscaRelatoriosAgendamentos(String? filtro) async {
    try {
      emit(
        state.copyWith(
          status: DashboardStatus.loading,
          relatoriosAgendamentos: [],
        ),
      );

      final response = await _repository.buscaRelatoriosAgendamentos(filtro);

      emit(
        state.copyWith(
          status: DashboardStatus.loaded,
          relatoriosAgendamentos: response,
        ),
      );
    } on RepositoryException catch (e, s) {
      log('$s');
      emit(
        state.copyWith(
          status: DashboardStatus.failure,
          errorMessage: e.message,
          relatoriosAgendamentos: [],
        ),
      );
    }
  }
}
