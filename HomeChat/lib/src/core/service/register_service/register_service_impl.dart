// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:homechat/src/core/exceptions/service_exception.dart';
import 'package:homechat/src/core/fp/either.dart';
import 'package:homechat/src/core/fp/nil.dart';
import 'package:homechat/src/core/repositories/auth/auth_repository.dart';
import 'package:homechat/src/core/service/login/login_service.dart';

import './register_service.dart';

class RegisterServiceImpl implements RegisterService {
  final AuthRepository authRepository;
  final LoginService loginService;
  RegisterServiceImpl({
    required this.authRepository,
    required this.loginService,
  });

  @override
  Future<Either<ServiceException, Nil>> execute(
      ({String email, String name, String password}) userData) async {
    final registerResult = await authRepository.register(userData);
    switch (registerResult) {
      case Success():
        return loginService.execute(userData.email, userData.password);
      case Failure(:final exception):
        return Failure(ServiceException(message: exception.message));
    }
  }
}
