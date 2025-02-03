// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ishopping/core/errors/service_exception.dart';
import 'package:ishopping/core/fp/either.dart';
import 'package:ishopping/core/fp/nil.dart';
import 'package:ishopping/src/repositories/auth/auth_user_repository.dart';
import 'package:ishopping/src/service/user_login/user_login_service.dart';
import 'package:ishopping/src/service/user_register/user_register_service.dart';

class UserRegisterServiceImpl implements UserRegisterService {
  final AuthUserRepository authUserRepository;
  final UserLoginService userLoginService;
  UserRegisterServiceImpl({
    required this.authUserRepository,
    required this.userLoginService,
  });

  //REGISTER
  @override
  Future<Either<ServiceException, Nil>> execute(
      ({String email, String name, String password}) userData) async {
    final registerResult = await authUserRepository.registerUser(userData);
    switch (registerResult) {
      case Success():
        return userLoginService.execute(userData.email, userData.password);
      case Failure(:final exception):
        return Failure(ServiceException(message: exception.message));
    }
  }
}
