import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servicespro/core/exceptions/repository_exception.dart';
import 'package:servicespro/src/repository/login_repository.dart';
import 'package:servicespro/src/states/login_state.dart';

class LoginController extends Cubit<LoginState> {
  final LoginRepository _loginRepository;

  LoginController(this._loginRepository) : super(LoginInitial());

  Future<void> login(String email, String password) async {
    try {
      emit(LoginInitial());
      final response = await _loginRepository.login(email, password);
      emit(LoginSuccess(response.token));
    } on RepositoryException catch (e) {
      emit(LoginFailure(errorMessage: e.message));
    }
  }
}
