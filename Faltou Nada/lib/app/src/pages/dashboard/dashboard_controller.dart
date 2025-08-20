import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:faltou_nada/app/core/exceptions/repository_exception.dart';
import 'package:faltou_nada/app/src/pages/dashboard/dashboard_state.dart';
import 'package:faltou_nada/app/src/repository/dashboard_repository.dart';

class DashboardController extends Cubit<DashboardState> {
  final DashboardRepository _dashboardRepository;

  DashboardController(this._dashboardRepository)
    : super(DashboardState.initial());

  Future<bool> enviarUrl(String url, String empresa) async {
    try {
      emit(state.copyWith(status: DashboardStatus.loading));

      await _dashboardRepository.enviarUrl(url, empresa);

      emit(state.copyWith(status: DashboardStatus.loaded));

      return true;
    } on RepositoryException catch (e, s) {
      log('$s');
      emit(
        state.copyWith(
          status: DashboardStatus.failure,
          errorMessage: e.message,
        ),
      );
      return false;
    }
  }

  Future<bool> buscaGastos() async {
    try {
      emit(state.copyWith(status: DashboardStatus.loading));

      final result = await _dashboardRepository.buscaGastos();

      emit(state.copyWith(status: DashboardStatus.loaded, cabeca: result));

      return true;
    } on RepositoryException catch (e, s) {
      log('$s');
      emit(
        state.copyWith(
          status: DashboardStatus.failure,
          errorMessage: e.message,
        ),
      );
      return false;
    }
  }

  Future<bool> buscaItensGastos(int mes, String ano) async {
    try {
      emit(state.copyWith(status: DashboardStatus.loading));

      final result = await _dashboardRepository.buscaItensGastos(mes, ano);

      emit(state.copyWith(status: DashboardStatus.loaded, itens: result));

      return true;
    } on RepositoryException catch (e, s) {
      log('$s');
      emit(
        state.copyWith(
          status: DashboardStatus.failure,
          errorMessage: e.message,
        ),
      );
      return false;
    }
  }

  Future<void> refresh() async {
    try {
      emit(state.copyWith(status: DashboardStatus.loading));

      emit(state.copyWith(status: DashboardStatus.loaded));
    } on RepositoryException catch (e, s) {
      log('$s');
      emit(
        state.copyWith(
          status: DashboardStatus.failure,
          errorMessage: e.message,
        ),
      );
    }
  }
}
