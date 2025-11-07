import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dente/core/exceptions/repository_exception.dart';
import 'package:dente/src/pages/login/login_state.dart';
import 'package:dente/src/repository/login_repository.dart';

class LoginController extends Cubit<LoginState> {
  final LoginRepository _repository;

  LoginController(this._repository) : super(LoginState.initial());

  Future<Map<String, dynamic>?> login(String email, String password) async {
    try {
      emit(state.copyWith(status: LoginStatus.loading));
      final response = await _repository.login(email, password);

      emit(state.copyWith(status: LoginStatus.sucess));
      return response;
    } on RepositoryException catch (e, s) {
      log('$s');
      emit(
        state.copyWith(status: LoginStatus.failure, errorMessage: e.message),
      );
      return null;
    }
  }
}
