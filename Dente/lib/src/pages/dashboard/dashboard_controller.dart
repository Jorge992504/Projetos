import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:dente/core/exceptions/repository_exception.dart';
import 'package:dente/src/pages/dashboard/dashboard_state.dart';
import 'package:dente/src/repository/dashboard_repository.dart';

class DashboardController extends Cubit<DashboardState> {
  final DashboardRepository _repository;

  DashboardController(this._repository) : super(DashboardState.initial());

  Future<void> buscaRelatorios() async {
    try {
      emit(state.copyWith(status: DashboardStatus.loading, relatorios: []));

      final response = await _repository.buscaRelatorios();

      emit(
        state.copyWith(status: DashboardStatus.loaded, relatorios: response),
      );
    } on RepositoryException catch (e, s) {
      log('$s');
      emit(
        state.copyWith(
          status: DashboardStatus.failure,
          errorMessage: e.message,
          relatorios: [],
        ),
      );
    }
  }
}
