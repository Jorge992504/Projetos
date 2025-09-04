import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:faltou_nada/app/core/exceptions/repository_exception.dart';
import 'package:faltou_nada/app/src/app_providers/auth_provider.dart';
import 'package:faltou_nada/app/src/models/auth_model.dart';
import 'package:faltou_nada/app/src/pages/login/login_state.dart';
import 'package:faltou_nada/app/src/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginController extends Cubit<LoginState> {
  final AuthRepository _authRepository;

  LoginController(this._authRepository) : super(LoginState.initial());

  Future<void> login(
    String email,
    String password,
    BuildContext context,
  ) async {
    try {
      emit(state.copyWith(status: LoginStatus.loading));
      AuthModel authModel = await _authRepository.login(email, password);
      // ignore: use_build_context_synchronously
      Provider.of<AuthProvider>(context, listen: false).login(authModel);
      emit(state.copyWith(status: LoginStatus.sucess));
    } on RepositoryException catch (e, s) {
      log('$s');
      emit(
        state.copyWith(status: LoginStatus.failure, errorMessage: e.message),
      );
    }
  }
}
