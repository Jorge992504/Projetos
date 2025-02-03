import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reborn/core/pages/cadastro/cadastro_state.dart';
import 'package:reborn/core/providers/auth_provider.dart';
import 'package:reborn/core/repositorio/cadastro_repositorio.dart';
import 'package:reborn/core/repositorio/login_repositorio.dart';

class CadastrarController extends Cubit<CadastrarState> {
  final CadastroRepository _authCadastro;
  late final LoginRepository _authLogin;
  late final AuthProvider _authProvider;

  CadastrarController(this._authCadastro, this._authLogin, this._authProvider)
      : super(CadastrarState.initial());

  Future<void> cadastrar(
      String usuario,
      String senha,
      String nome,
      String sobrenome,
      double peso,
      double altura,
      String email,
      DateTime nascimento) async {
    try {
      emit(
        state.copyWith(status: CadastroStatus.register),
      );
      await _authCadastro.cadastro(
          usuario, senha, nome, sobrenome, peso, altura, email, nascimento);
      //
      final authLogin = await _authLogin.login(usuario, senha);
      _authProvider.atualizarUsuario(usuario, authLogin.token);
      emit(
        state.copyWith(status: CadastroStatus.success),
      );
    } catch (e, s) {
      log('Erro ao cadastrar usuário', error: e, stackTrace: s);
      emit(
        state.copyWith(status: CadastroStatus.error),
      );
    }
  }
}
