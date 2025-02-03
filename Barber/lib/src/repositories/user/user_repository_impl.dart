// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:barber/src/core/exceptions/auth_exception.dart';
import 'package:barber/src/core/exceptions/repository_exeception.dart';
import 'package:barber/src/core/fp/either.dart';
import 'package:barber/src/core/fp/nil.dart';
import 'package:barber/src/core/restClient/rest_client.dart';
import 'package:barber/src/models/user_model.dart';
import 'package:barber/src/repositories/user/user_repository.dart';

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
      final tokenT = token.data['token'];

      return Success(tokenT);
    } on DioException catch (e, s) {
      if (e.response != null) {
        final Response(:statusCode) = e.response!;
        if (statusCode == 403) {
          {
            log('Login ou senha invalidos', error: e, stackTrace: s);
            return Failure(AuthUnauthorizedExecption());
          }
        }
      }
      log('Erro ao realizar login', error: e, stackTrace: s);
      return Failure(AuthError(message: 'Erro ao realizar login'));
    }
  }

  @override
  Future<Either<RepositoryExeception, UserModel>> me() async {
    try {
      final Response(:data) = await restClient.auth.get('/usuarios');
      return Success(UserModel.fromMap(data));
    } on Exception catch (e, s) {
      log('Erro ao buscar usuario logado', error: e, stackTrace: s);
      return Failure(
        RepositoryExeception(message: 'Erro ao buscar usuario logado'),
      );
    }
  }

  @override
  Future<Either<RepositoryExeception, Nil>> registerAdmin(
      ({
        String emai,
        String name,
        String password,
        String profile,
      }) userData) async {
    try {
      await restClient.unauth.post('/usuarios', data: {
        'name': userData.name,
        'email': userData.emai,
        'password': userData.password,
        'profile': 'ADM',
      });
      return Success(nil);
    } on DioException catch (e, s) {
      log('Erro ao registrar usuário admin', error: e, stackTrace: s);
      return Failure(
          RepositoryExeception(message: 'Erro ao registrar usuário admin'));
    }
  }

  @override
  Future<Either<RepositoryExeception, List<UserModel>>> getEmployee(
      int barbershopId) async {
    try {
      final Response(:List data) = await restClient.auth
          .get('/barbershop', queryParameters: {'barbershop_id': barbershopId});
      final employees = data.map((e) => UserModelEmployee.fromMap(e)).toList();

      return Success(employees);
    } on DioException catch (e, s) {
      log('Erro ao buscar colaboradores', error: e, stackTrace: s);
      return Failure(
          RepositoryExeception(message: 'Erro ao buscar colaboradores'));
    } on ArgumentError catch (e, s) {
      log('Erro ao converter colaboradores (Invalid Json)',
          error: e, stackTrace: s);
      return Failure(
          RepositoryExeception(message: 'Erro ao buscar colaboradores'));
    }
  }
}
