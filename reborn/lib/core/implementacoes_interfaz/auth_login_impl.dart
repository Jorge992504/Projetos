// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:reborn/core/custom_dio/custom_dio.dart';
import 'package:reborn/core/erros/exception.dart';
import 'package:reborn/core/erros/sem_auth.dart';
import 'package:reborn/core/modelos/modelo_login.dart';
import 'package:reborn/core/modelos/modelo_usuario.dart';
import 'package:reborn/core/repositorio/login_repositorio.dart';

class AuthLoginImpl implements LoginRepository {
  final CustomDio dio;
  AuthLoginImpl({
    required this.dio,
  });
  @override
  Future<ModeloLogin> login(String usuario, String senha) async {
    try {
      final resultado = await dio.unauth().post('/login', data: {
        'user': usuario,
        'pass': senha,
      });
      return ModeloLogin.fromMap(resultado.data);
    } on DioException catch (e, s) {
      if (e.response?.statusCode == 403) {
        log('Permissão negada', error: e, stackTrace: s);
        throw SemAuth();
      } else if (e.response?.statusCode == 400) {
        log(e.response!.data.error, error: e, stackTrace: s);
        throw ExceptionErros(message: e.response!.data.error);
      }
      log('Error ao realizar Login', error: e, stackTrace: s);
      throw ExceptionErros(message: 'Erro ao realizar login');
    }
  }

  @override
  Future<ModeloUsuario> consultaUsuario() async {
    try {
      final resultado = await dio.auth().get('/usuario');
      return ModeloUsuario.fromMap(resultado.data);
    } on DioException catch (e, s) {
      if (e.response?.statusCode == 403) {
        log('Permissão negada', error: e, stackTrace: s);
        throw SemAuth();
      } else if (e.response?.statusCode == 400) {
        log(e.response!.data.error, error: e, stackTrace: s);
        throw ExceptionErros(message: e.response!.data.error);
      }

      log('Erro ao buscar dados do usuário', error: e, stackTrace: s);
      throw ExceptionErros(
        message: 'Erro ao buscar dados do usuário',
      );
    }
  }
}
