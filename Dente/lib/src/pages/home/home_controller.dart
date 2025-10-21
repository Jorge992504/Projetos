import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:dente/core/exceptions/repository_exception.dart';
import 'package:dente/src/pages/home/home_state.dart';
import 'package:dente/src/repository/home_repository.dart';

class HomeController extends Cubit<HomeState> {
  final HomeRepository _repository;

  HomeController(this._repository) : super(HomeState.initial());

  Future<void> buscaAgendamentos() async {
    try {
      emit(state.copyWith(status: HomeStatus.loading));

      final response = await _repository.buscaAgendamentos();

      emit(
        state.copyWith(
          status: HomeStatus.loaded,
          errorMessage: null,
          agendamentos: response,
        ),
      );
    } on RepositoryException catch (e, s) {
      log('$s');
      emit(state.copyWith(status: HomeStatus.failure, errorMessage: e.message));
    }
  }
}
