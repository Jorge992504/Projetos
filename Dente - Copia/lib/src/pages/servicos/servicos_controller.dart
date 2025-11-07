import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:dente/core/exceptions/repository_exception.dart';
import 'package:dente/src/models/servicos_model.dart';
import 'package:dente/src/pages/servicos/servicos_state.dart';
import 'package:dente/src/repository/servicos_repository.dart';

class ServicosController extends Cubit<ServicosState> {
  final ServicosRepository _repository;

  ServicosController(this._repository) : super(ServicosState.initial());

  Future<void> registrarServicos(ServicosModel servicosModel) async {
    try {
      emit(state.copyWith(status: ServicosStatus.loading));

      await _repository.registrarServicos(servicosModel);

      final current = state.servicos ?? [];
      final updatedDentistas = current.map((d) {
        if (d.nome == servicosModel.nome) {
          return servicosModel; // substitui pelo dentista atualizado
        }
        return d;
      }).toList();

      emit(
        state.copyWith(
          status: ServicosStatus.success,
          errorMessage: null,
          servicos: updatedDentistas,
        ),
      );
    } on RepositoryException catch (e, s) {
      log('$s');
      emit(
        state.copyWith(status: ServicosStatus.failure, errorMessage: e.message),
      );
    }
  }

  Future<void> buscarServicos() async {
    try {
      emit(state.copyWith(status: ServicosStatus.loading));

      final response = await _repository.buscarServicos();

      emit(
        state.copyWith(
          status: ServicosStatus.loaded,
          errorMessage: null,
          servicos: response,
        ),
      );
    } on RepositoryException catch (e, s) {
      log('$s');
      emit(
        state.copyWith(status: ServicosStatus.failure, errorMessage: e.message),
      );
    }
  }
}
