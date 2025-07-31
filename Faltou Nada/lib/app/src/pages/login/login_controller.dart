import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:faltou_nada/app/core/exceptions/repository_exception.dart';
import 'package:faltou_nada/app/src/pages/login/login_state.dart';
import 'package:faltou_nada/app/src/repository/auth_repository.dart';
import 'package:flutter/material.dart';

class LoginController extends Cubit<LoginState> {
  final AuthRepository _authRepository;

  LoginController(this._authRepository) : super(LoginState.initial());

  Future<void> login(
      String email, String password, BuildContext context) async {
    try {
      emit(state.copyWith(status: LoginStatus.loading));
      final authModel = await _authRepository.login(email, password);
      if (authModel.token.isNotEmpty) {
        emit(state.copyWith(
          status: LoginStatus.sucess,
        ));
      }
      // emit(state.copyWith(
      //   status: LoginStatus.sucess,
      // ));
    } on RepositoryException catch (e, s) {
      log('$s');
      emit(
          state.copyWith(status: LoginStatus.failure, errorMessage: e.message));
    }
  }
}
