// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:activovo/src/custom/keys.dart';
import 'package:activovo/src/error/auth_exception.dart';
import 'package:activovo/src/error/service_exception.dart';
import 'package:activovo/src/funtional_prog/either.dart';
import 'package:activovo/src/funtional_prog/nil.dart';
import 'package:activovo/src/repositories/user/user_repository.dart';
import 'package:activovo/src/services/user_login/user_login_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserLoginServiceImpl implements UserLoginService {
  final UserRepository userRepository;
  UserLoginServiceImpl({
    required this.userRepository,
  });
  @override
  Future<Either<ServiceException, Nil>> execute(
      String email, String password) async {
    final loginResult = await userRepository.login(email, password);
    switch (loginResult) {
      case Success(value: final accessToken):
        final sp = await SharedPreferences.getInstance();
        sp.setString(Keys.token, accessToken);
        return Success(nil);
      case Failure(:final exception):
        switch (exception) {
          case AuthError():
            return Failure(ServiceException(message: 'Erro ao realizar login'));
          case AuthUnauthorizedException():
            return Failure(
                ServiceException(message: 'Login ou senha inválido'));
        }
    }
  }
}
