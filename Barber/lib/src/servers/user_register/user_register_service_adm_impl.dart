// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:barber/src/core/exceptions/service_exeception.dart';
import 'package:barber/src/core/fp/either.dart';
import 'package:barber/src/core/fp/nil.dart';
import 'package:barber/src/repositories/user/user_repository.dart';
import 'package:barber/src/servers/user_login/user_login.dart';
import 'package:barber/src/servers/user_register/user_register_service_adm.dart';

class UserRegisterServiceAdmImpl implements UserRegisterServiceAdm {
  final UserRepository userRepository;
  final UserLogin userLogin;
  UserRegisterServiceAdmImpl({
    required this.userRepository,
    required this.userLogin,
  });
  @override
  Future<Either<ServiceExeception, Nil>> execute(
      ({
        String emai,
        String name,
        String password,
        String profile,
      }) userData) async {
    final registerResult = await userRepository.registerAdmin(userData);
    switch (registerResult) {
      case Success():
        return userLogin.execute(userData.emai, userData.password);
      case Failure(:final exception):
        return Failure(ServiceExeception(message: exception.message));
    }
  }
}
