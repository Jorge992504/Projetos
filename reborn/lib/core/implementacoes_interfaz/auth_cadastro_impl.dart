import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:reborn/core/custom_dio/custom_dio.dart';
import 'package:reborn/core/erros/exception.dart';

import 'package:reborn/core/repositorio/cadastro_repositorio.dart';

class AuthCadastroImpl implements CadastroRepository {
  final CustomDio dio;
  AuthCadastroImpl({required this.dio});
  @override
  Future<void> cadastro(
    String usuairo,
    String senha,
    String nome,
    String sobrenome,
    double peso,
    double altura,
    String email,
    DateTime nascimento,
  ) async {
    try {
      await dio.unauth().post('/usuario', data: {
        'user': usuairo,
        'senha': senha,
        'nm': nome,
        'sob': sobrenome,
        'peso': double.parse(peso.toString()),
        'alt': double.parse(altura.toString()),
        'email': email,
        'dt': DateFormat("yyyyMMdd").format(nascimento),
        'doenca': "",
      });
    } on DioException catch (e, s) {
      log('Erro ao cadastrar usuário', error: e, stackTrace: s);
      throw ExceptionErros(message: 'Erro ao cadastrar usuário');
    }
  }
}
