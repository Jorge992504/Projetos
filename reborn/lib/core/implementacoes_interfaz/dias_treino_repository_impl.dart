import 'dart:developer';

import 'package:dio/dio.dart';

import 'package:reborn/core/custom_dio/custom_dio.dart';
import 'package:reborn/core/erros/exception.dart';
import 'package:reborn/core/modelos/modelo_dias_treino.dart';

import 'package:reborn/core/repositorio/dias_treino_repository.dart';

class DiasTreinoRepositoryImpl implements DiasTreinoRepository {
  final CustomDio dio;

  DiasTreinoRepositoryImpl({required this.dio});

  @override
  Future<void> relacionarUsuarioDiasTreino(List<int> dias) async {
    try {
      await dio.auth().post('/usuario/treino', data: dias);
    } on DioException catch (e, s) {
      log('Erro ao relacionar os dias de treino', error: e, stackTrace: s);
      throw ExceptionErros(message: 'Erro ao relacionar os dias de treino');
    }
  }

  @override
  Future<List<ModeloDiasTreino>> listarDiasTreino() async {
    try {
      final result = await dio.unauth().get('/treino');

      return result.data
          .map<ModeloDiasTreino>(
            (exe) => ModeloDiasTreino.fromMap(exe),
          )
          .toList();
    } on DioException catch (e, s) {
      log('Erro ao buscar os treinos', error: e, stackTrace: s);
      throw ExceptionErros(message: 'Treinos indisponiveis');
    }
  }
}
