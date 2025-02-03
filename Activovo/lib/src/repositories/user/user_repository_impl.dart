// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:activovo/src/error/auth_exception.dart';
import 'package:activovo/src/error/repository_exception.dart';
import 'package:activovo/src/funtional_prog/either.dart';
import 'package:activovo/src/funtional_prog/nil.dart';
import 'package:activovo/src/models/model_user.dart';
import 'package:activovo/src/repositories/user/user_repository.dart';
import 'package:activovo/src/restClient/rest_client.dart';
import 'package:dio/dio.dart';

class UserRepositoryImpl implements UserRepository {
  final RestClient restClient;
  UserRepositoryImpl({
    required this.restClient,
  });

  @override
  Future<Either<AuthException, String>> login(
      String email, String password) async {
    try {
      final token = await restClient.unauth.post(
        '/login',
        data: {
          'email': email,
          'password': password,
        },
      );
      final accessToken = token.data['token'];
      return Success(accessToken);
    } on DioException catch (e, s) {
      if (e.response != null) {
        final Response(:statusCode) = e.response!;
        if (statusCode == 403) {
          {
            log('Login ou senha invalidos', error: e, stackTrace: s);
            return Failure(
              AuthUnauthorizedException(message: 'Sem autorização'),
            );
          }
        }
      }
      log('Erro ao realizar login', error: e, stackTrace: s);
      return Failure(AuthError(message: 'Erro ao realizar login'));
    }
  }

  @override
  Future<Either<RepositoryException, ModelUser>> me() async {
    try {
      final Response(:data) = await restClient.auth.get('/users');
      return Success(ModelUser.fromMap(data));
    } on DioException catch (e, s) {
      log('Erro ao buscar usuário logado', error: e, stackTrace: s);
      return Failure(
          RepositoryException(message: 'Erro ao buscar usuário logado'));
    } on ArgumentError catch (e, s) {
      log('Invalid Json', error: e, stackTrace: s);
      return Failure(RepositoryException(message: e.message));
    }
  }

  @override
  Future<Either<RepositoryException, Nil>> registerUser(
      ({
        String email,
        String name,
        String password,
      }) userData) async {
    try {
      await restClient.unauth.post('/users', data: {
        'name': userData.name,
        'email': userData.email,
        'password': userData.password,
        'profile': 'user',
      });
      return Success(nil);
    } on DioException catch (e, s) {
      log('Erro ao registrar usuário', error: e, stackTrace: s);
      return Failure(RepositoryException(message: 'Erro ao registrar usuário'));
    }
  }
}
