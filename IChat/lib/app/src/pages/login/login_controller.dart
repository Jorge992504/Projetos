import 'package:bloc/bloc.dart';
import 'package:ichat/app/core/exceptions/repository_exception.dart';
import 'package:ichat/app/src/pages/login/login_state.dart';
import 'package:ichat/app/src/providers/auth_provider.dart';

class LoginController extends Cubit<LoginState> {
  final AuthProvider _authProvider;

  LoginController(this._authProvider) : super(LoginState.initial());

  Future<void> login(String email, String password) async {
    try {
      emit(state.copyWith(status: LoginStatus.loading));
      await _authProvider.login(email, password);
      emit(state.copyWith(status: LoginStatus.success));
    } on RepositoryException catch (e) {
      emit(state.copyWith(status: LoginStatus.error, errorMessage: e.message));
    } catch (e) {
      emit(
        state.copyWith(
          status: LoginStatus.error,
          errorMessage: 'Erro ao realizar login',
        ),
      );
    }
  }
}
