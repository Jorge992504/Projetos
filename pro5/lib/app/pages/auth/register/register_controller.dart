import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:delivery/app/pages/auth/register/register_state.dart';

import 'package:delivery/app/repositories/auth/auth_repository.dart';

class RegisterController extends Cubit<RegisterState> {
  final AuthRepository _authRepository;
  RegisterController(this._authRepository) : super(RegisterState.initial());

  Future<void> registerUsuarios(String email, String nome, String senha) async {
    try {
      emit(state.copyWith(status: RegisterStatus.register));
      await _authRepository.registerUsuarios(email, nome, senha);
      emit(state.copyWith(status: RegisterStatus.success));
    } catch (e, s) {
      log('Erro ao registrar usuário', error: e, stackTrace: s);
      emit(state.copyWith(status: RegisterStatus.error));
    }
  }
}
