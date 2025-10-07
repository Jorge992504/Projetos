import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dente/core/exceptions/repository_exception.dart';
import 'package:dente/src/models/empresa_model.dart';
import 'package:dente/src/pages/registrar_empresa/registrar_empresa_state.dart';
import 'package:dente/src/repository/registrar_empresa_repository.dart';

class RegistrarEmpresaController extends Cubit<RegistrarEmpresaState> {
  final RegistrarEmpresaRepository _repository;

  RegistrarEmpresaController(this._repository)
    : super(RegistrarEmpresaState.initial());

  Future<Map<String, dynamic>> register(EmpresaModel model) async {
    try {
      emit(state.copyWith(status: RegistrarEmpresaStatus.loading));

      final result = await _repository.register(model);

      emit(
        state.copyWith(
          status: RegistrarEmpresaStatus.success,
          errorMessage: null,
        ),
      );
      return result;
    } on RepositoryException catch (e, s) {
      log('$s');
      emit(
        state.copyWith(
          status: RegistrarEmpresaStatus.failure,
          errorMessage: e.message,
        ),
      );
      return {};
    }
  }
}
