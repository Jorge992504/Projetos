import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dente/core/exceptions/repository_exception.dart';
import 'package:dente/src/pages/reset_password/reset_password_state.dart';
import 'package:dente/src/repository/reset_password_repository.dart';

class ResetPasswordController extends Cubit<ResetPasswordState> {
  final ResetPasswordRepository _repository;

  ResetPasswordController(this._repository)
    : super(ResetPasswordState.initial());

  Future<void> enviaEmailRedefineSenha(String email) async {
    try {
      emit(state.copyWith(status: ResetPasswordStatus.loading));

      await _repository.enviaEmailRedefineSenha(email);

      emit(
        state.copyWith(status: ResetPasswordStatus.success, errorMessage: null),
      );
    } on RepositoryException catch (e, s) {
      log('$s');
      emit(
        state.copyWith(
          status: ResetPasswordStatus.failure,
          errorMessage: e.message,
        ),
      );
    }
  }

  Future<bool> verificaCodigo(int codigo, String email) async {
    try {
      emit(state.copyWith(status: ResetPasswordStatus.loading));

      await _repository.verificaCodigo(codigo, email);

      emit(
        state.copyWith(status: ResetPasswordStatus.success, errorMessage: null),
      );
      return true;
    } on RepositoryException catch (e, s) {
      log('$s');
      emit(
        state.copyWith(
          status: ResetPasswordStatus.failure,
          errorMessage: e.message,
        ),
      );
      return false;
    }
  }
}
