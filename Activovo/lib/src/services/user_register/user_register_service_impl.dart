// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:activovo/src/error/service_exception.dart';
import 'package:activovo/src/funtional_prog/either.dart';
import 'package:activovo/src/funtional_prog/nil.dart';
import 'package:activovo/src/repositories/user/user_repository.dart';
import 'package:activovo/src/services/user_login/user_login_service.dart';
import 'package:activovo/src/services/user_register/user_register_service.dart';

class UserRegisterServiceImpl implements UserRegisterService {
  final UserRepository userRepository;
  final UserLoginService userLoginService;
  UserRegisterServiceImpl({
    required this.userRepository,
    required this.userLoginService,
  });
  @override
  Future<Either<ServiceException, Nil>> execute(
      ({String email, String name, String password}) userData) async {
    final registerResult = await userRepository.registerUser(userData);
    switch (registerResult) {
      case Success():
        return userLoginService.execute(userData.email, userData.password);
      case Failure(:final exception):
        return Failure(ServiceException(message: exception.message));
    }
  }
}
