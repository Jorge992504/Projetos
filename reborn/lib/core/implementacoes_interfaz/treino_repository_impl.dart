import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:reborn/core/custom_dio/custom_dio.dart';
import 'package:reborn/core/erros/exception.dart';

class TreinoRepositoryImpl {
  final CustomDio dio;
  TreinoRepositoryImpl({required this.dio});

  Future<void> criarTreino() async {
    try {
      await dio.auth().post('/usuario/treino_semana');
    } on DioException catch (e, s) {
      log('Erro ao criar o treino', error: e, stackTrace: s);
      throw ExceptionErros(message: 'Erro ao criar o treino');
    }
  }
}
