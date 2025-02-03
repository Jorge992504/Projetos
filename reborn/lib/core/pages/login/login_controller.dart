// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:bloc/bloc.dart';

import 'package:reborn/core/erros/sem_auth.dart';
import 'package:reborn/core/pages/login/login_status.dart';
import 'package:reborn/core/providers/auth_provider.dart';
import 'package:reborn/core/repositorio/login_repositorio.dart';

class LoginController extends Cubit<LoginState> {
  late final LoginRepository _authLogin;
  late final AuthProvider _authProvider;

  LoginController(
    this._authLogin,
    this._authProvider,
  ) : super(const LoginState.inital());

  Future<void> login(String usuario, String senha) async {
    try {
      emit(state.copyWith(status: LoginStatus.login));
      final authLogin = await _authLogin.login(usuario, senha);
      _authProvider.atualizarUsuario(usuario, authLogin.token);
      emit(state.copyWith(status: LoginStatus.success));
    } on SemAuth catch (e, s) {
      log('Usuário e senha invalidos', error: e, stackTrace: s);
      emit(state.copyWith(
        status: LoginStatus.loginError,
        errorMessage: 'Usuário ou senha invalidos',
      ));
    } catch (e, s) {
      log(
        'Erro ao realizar login',
        error: e,
        stackTrace: s,
      );
      emit(state.copyWith(
        status: LoginStatus.error,
        errorMessage: 'Erro ao realizar login',
      ));
    }
  }
}
