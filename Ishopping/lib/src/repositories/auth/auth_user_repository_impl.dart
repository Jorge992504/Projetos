// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ishopping/core/errors/auth_exception.dart';
import 'package:ishopping/core/errors/repository_exception.dart';
import 'package:ishopping/core/fp/either.dart';
import 'package:ishopping/core/fp/nil.dart';
import 'package:ishopping/core/restClient/rest_client.dart';
import 'package:ishopping/src/models/user_model.dart';
import 'package:ishopping/src/repositories/auth/auth_user_repository.dart';

class AuthUserRepositoryImpl implements AuthUserRepository {
  final RestClient restClient;
  AuthUserRepositoryImpl({
    required this.restClient,
  });

  //LOGIN USER
  @override
  Future<Either<AuthException, String>> loginUser(
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
          log('E-mail ou senha inválidos', error: e.error, stackTrace: s);
          return Failure(AuthUnauthorizedExecption(message: 'Sem autorização'));
        }
      }
      log('Erro ao realizar login', error: e.error, stackTrace: s);
      return Failure(AuthError(message: 'Erro ao realizar login'));
    }
  }

  //REGISTER USER
  @override
  Future<Either<RepositoryException, Nil>> registerUser(
      ({String email, String name, String password}) userData) async {
    try {
      await restClient.unauth.post('/users', data: {
        'name': userData.name,
        'email': userData.email,
        'password': userData.password,
      });
      return Success(nil);
    } on DioException catch (e, s) {
      log('Erro ao registrar usuário', error: e.error, stackTrace: s);
      log('Message do erro: ', error: e.message);
      return Failure(RepositoryException(message: 'Erro ao realizar login'));
    }
  }

  //USER LOGADO
  @override
  Future<Either<RepositoryException, UserModel>> me() async {
    try {
      final Response(:data) = await restClient.auth.get('/users');
      return Success(UserModel.fromMap(data));
    } on DioException catch (e, s) {
      log('Erro ao buscar usuário logado', error: e, stackTrace: s);
      return Failure(
          RepositoryException(message: 'Erro ao buscar usuário logado'));
    } on ArgumentError catch (e, s) {
      log('Invalid Json', error: e, stackTrace: s);
      return Failure(RepositoryException(message: e.message));
    }
  }
}
