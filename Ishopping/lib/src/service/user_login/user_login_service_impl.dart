// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ishopping/core/errors/auth_exception.dart';
import 'package:ishopping/core/errors/service_exception.dart';
import 'package:ishopping/core/fp/either.dart';
import 'package:ishopping/core/fp/nil.dart';
import 'package:ishopping/core/keys/LocalStorageKeys.dart';
import 'package:ishopping/src/repositories/auth/auth_user_repository.dart';
import 'package:ishopping/src/service/user_login/user_login_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserLoginServiceImpl implements UserLoginService {
  final AuthUserRepository authUserRepository;
  UserLoginServiceImpl({
    required this.authUserRepository,
  });

  //LOGIN
  @override
  Future<Either<ServiceException, Nil>> execute(
      String email, String password) async {
    final loginResult = await authUserRepository.loginUser(email, password);
    switch (loginResult) {
      case Success(value: final accessToken):
        final sp = await SharedPreferences.getInstance();
        sp.setString(LocalStorageKeys.token, accessToken);
        return Success(nil);
      case Failure(:final exception):
        switch (exception) {
          case AuthError():
            return Failure(ServiceException(message: 'Erro ao realizar login'));
          case AuthUnauthorizedExecption():
            return Failure(
                ServiceException(message: 'Usuário ou senha inválidos'));
        }
    }
  }
}
