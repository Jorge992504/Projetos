// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:homechat/src/core/exceptions/auth_exception.dart';
import 'package:homechat/src/core/exceptions/service_exception.dart';
import 'package:homechat/src/core/fp/either.dart';
import 'package:homechat/src/core/fp/nil.dart';
import 'package:homechat/src/core/keys/local_storage_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../repositories/auth/auth_repository.dart';
import './login_service.dart';

class LoginServiceImpl implements LoginService {
  final AuthRepository authRepository;
  LoginServiceImpl({
    required this.authRepository,
  });

  @override
  Future<Either<ServiceException, Nil>> execute(
      String email, String password) async {
    try {
      final loginResult = await authRepository.login(email, password);
      switch (loginResult) {
        case Success(value: final accessToken):
          final sp = await SharedPreferences.getInstance();
          sp.setString(LocalStorageKeys.token, accessToken);
          return Success(nil);
        case Failure(:final exception):
          switch (exception) {
            case AuthError():
              return Failure(
                  ServiceException(message: 'Erro ao realizar login'));
            case AuthUnauthorizedExecption():
              return Failure(
                  ServiceException(message: 'Usuário ou senha inválidos'));
          }
      }
    } on DioException catch (e, s) {
      log('Dados inválidos', error: e, stackTrace: s);
      return Failure(ServiceException(message: 'Invalid JSON'));
    }
    return Failure(ServiceException(message: 'Erro inesperado'));
  }
}
