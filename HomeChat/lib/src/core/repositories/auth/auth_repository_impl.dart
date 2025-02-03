// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:homechat/src/core/client/res_client.dart';
import 'package:homechat/src/core/exceptions/auth_exception.dart';

import 'package:homechat/src/core/exceptions/repository_exception.dart';
import 'package:homechat/src/core/fp/either.dart';
import 'package:homechat/src/core/fp/nil.dart';
import 'package:homechat/src/core/models/user_model.dart';

import './auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final RestClient restClient;
  AuthRepositoryImpl({
    required this.restClient,
  });
  @override
  Future<Either<RepositoryException, String>> login(
      String email, String password) async {
    try {
      final token = await restClient.unauth
          .post('/login', data: {'email': email, 'password': password});
      final accessToken = token.data['token'];
      return Success(accessToken);
    } on DioException catch (e, s) {
      if (e.response != null) {
        final Response(:statusCode) = e.response!;
        if (statusCode == 403) {
          log('E-mail ou senha inválidos');
          return Failure(AuthUnauthorizedExecption(message: 'Sem autorização')
              as RepositoryException);
        }
      }
      log('Erro ao realizar login', error: e.error, stackTrace: s);
      return Failure(
          AuthError(message: 'Erro ao realizar login') as RepositoryException);
    }
  }

  @override
  Future<Either<RepositoryException, UserModel>> me() async {
    try {
      final Response(:data) = await restClient.auth.get('/users');
      if (data != null) {
        return Success(UserModel.fromMap(data));
      } else {
        return Failure(
            RepositoryException(message: 'Dados vazios recebidos da API'));
      }
    } on DioException catch (e, s) {
      log('Erro ao buscar usuário logado', error: e, stackTrace: s);
      return Failure(
          RepositoryException(message: 'Erro de requisição: ${e.message}'));
    } on ArgumentError catch (e, s) {
      log('Invalid JSON AuthRepositoryImpl', error: e, stackTrace: s);
      return Failure(RepositoryException(
          message: 'Erro ao interpretar JSON: ${e.message}'));
    } catch (e, s) {
      log('Erro desconhecido', error: e, stackTrace: s);
      return Failure(RepositoryException(message: 'Erro desconhecido: $e'));
    }
  }

  @override
  Future<Either<RepositoryException, Nil>> register(
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
      log('Message de erro: ', error: e.message);
      return Failure(RepositoryException(message: 'Erro ao realizar cadastro'));
    }
  }
}
