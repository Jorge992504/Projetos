import 'dart:developer';

import 'package:dio/dio.dart';

import 'package:reborn/core/custom_dio/custom_dio.dart';
import 'package:reborn/core/erros/exception.dart';
import 'package:reborn/core/modelos/modelo_exercicios.dart';

import 'package:reborn/core/repositorio/exercicios_repositorio.dart';

class ExerciciosRepositoryImpl implements ExerciciosRepository {
  final CustomDio dio;
  ExerciciosRepositoryImpl({required this.dio});

  @override
  Future<List<ModeloExercicio>> findAllExercicios() async {
    try {
      final result = await dio.unauth().get('/exercicio');
      return result.data
          .map<ModeloExercicio>(
            (exe) => ModeloExercicio.fromMap(exe),
          )
          .toList();
    } on DioException catch (e, s) {
      log('Erro ao buscar a lista de exercicios', error: e, stackTrace: s);
      throw ExceptionErros(message: 'Exericicios indisponiveis');
    }
  }
}
