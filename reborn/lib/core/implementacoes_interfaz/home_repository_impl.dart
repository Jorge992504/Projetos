import 'dart:developer';

import 'package:dio/dio.dart';

import 'package:reborn/core/custom_dio/custom_dio.dart';
import 'package:reborn/core/erros/exception.dart';
import 'package:reborn/core/modelos/modelo_exercicios.dart';

import 'package:reborn/core/repositorio/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final CustomDio dio;

  HomeRepositoryImpl({required this.dio});

  @override
  Future<List<ModeloExercicio>> listarTreino() async {
    try {
      DateTime agr = DateTime.now();
      int diaSemana = agr.weekday;
      final result = await dio.auth().get('/usuario/treino/$diaSemana');
      return result.data
          .map<ModeloExercicio>(
            (exe) => ModeloExercicio.fromMap(exe),
          )
          .toList();
    } on DioException catch (e, s) {
      log('Erro ao buscar o treino', error: e, stackTrace: s);
      throw ExceptionErros(message: 'Não tem treino disponivel');
    }
  }
}
