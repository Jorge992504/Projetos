import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dente/core/exceptions/repository_exception.dart';
import 'package:dente/src/models/empresa_model.dart';
import 'package:dente/src/pages/editar_empresa/editar_empresa_state.dart';
import 'package:dente/src/repository/editar_empresa_repository.dart';

class EditarEmpresaController extends Cubit<EditarEmpresaState> {
  final EditarEmpresaRepository _repository;

  EditarEmpresaController(this._repository)
    : super(EditarEmpresaState.initial());

  Future<void> gravaEditarEmpresa(EmpresaModel empresaModel) async {
    try {
      emit(state.copyWith(status: EditarEmpresaStatus.loading));

      await _repository.gravaEditarEmpresa(empresaModel);

      emit(state.copyWith(status: EditarEmpresaStatus.success));
    } on RepositoryException catch (e, s) {
      log('$s');
      emit(
        state.copyWith(
          status: EditarEmpresaStatus.failure,
          errorMessage: e.message,
        ),
      );
    }
  }
}
