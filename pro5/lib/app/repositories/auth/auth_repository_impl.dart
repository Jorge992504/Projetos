// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:delivery/app/core/rest_client/custom_dio.dart';
import 'package:delivery/app/models/auth_model.dart';
import 'package:delivery/app/repositories/auth/auth_repository.dart';
import 'package:delivery/app/repositories/exception/repository_exception.dart';
import 'package:delivery/app/repositories/exception/unauthorized_exception.dart';
import 'package:dio/dio.dart';

class AuthRepositoryImpl implements AuthRepository {
  final CustomDio dio;
  AuthRepositoryImpl({
    required this.dio,
  });
  @override
  Future<AuthModel> login(String email, String senha) async {
    try {
      final result = await dio.anuath().post('login', data: {
        'email': email,
        'senha': senha,
      });
      return AuthModel.fromMap(result.data);
    } on DioError catch (e, s) {
      if (e.response?.statusCode == 403) {
        log('Permissão negada', error: e, stackTrace: s);
        throw UnauthorizedException();
      }
      log('Erro ao realizar login', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao realizar login');
    }
  }

  @override
  Future<void> registerUsuarios(String email, String nome, String senha) async {
    try {
      await dio.anuath().post('/usuarios', data: {
        'email': email,
        'nome': nome,
        'senha': senha,
      });
    } on DioError catch (e, s) {
      log('Erro ao registrar usuário', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao registrar usuário');
    }
  }
}
