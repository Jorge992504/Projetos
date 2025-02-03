// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:barber/src/core/constants/local_storage_keys.dart';
import 'package:barber/src/core/exceptions/auth_exception.dart';
import 'package:barber/src/core/exceptions/service_exeception.dart';
import 'package:barber/src/core/fp/either.dart';
import 'package:barber/src/core/fp/nil.dart';
import 'package:barber/src/repositories/user/user_repository.dart';
import 'package:barber/src/servers/user_login/user_login.dart';

import 'package:shared_preferences/shared_preferences.dart';

class UserLoginImpl implements UserLogin {
  final UserRepository userRepository;
  UserLoginImpl({
    required this.userRepository,
  });
  @override
  Future<Either<ServiceExeception, Nil>> execute(
      String email, String password) async {
    final loginResult = await userRepository.login(email, password);

    switch (loginResult) {
      case Success(value: final token):
        final sp = await SharedPreferences.getInstance();
        sp.setString(LocalStorageKeys.token, token);

        return Success(nil);
      case Failure(:final exception):
        switch (exception) {
          case AuthError():
            return Failure(
                ServiceExeception(message: 'Erro ao realizar login'));
          case AuthUnauthorizedExecption():
            return Failure(
                ServiceExeception(message: 'Login ou senha invalidos'));
        }
    }
  }
}
