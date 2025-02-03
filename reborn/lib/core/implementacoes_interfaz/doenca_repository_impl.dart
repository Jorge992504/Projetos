import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:reborn/core/custom_dio/custom_dio.dart';
import 'package:reborn/core/erros/exception.dart';
import 'package:reborn/core/modelos/modelo_dias_treino.dart';
import 'package:reborn/core/modelos/modelo_doenca.dart';
import 'package:reborn/core/repositorio/doenca_repository.dart';

class DoencaRepositoryImpl implements DoencaRepository {
  final CustomDio dio;

  DoencaRepositoryImpl({required this.dio});

  @override
  Future<void> relacionarUsuarioDoenca(List<int> doencas) async {
    try {
      await dio.auth().post('/usuario/doenca', data: doencas);
    } on DioException catch (e, s) {
      log('Erro ao relacionar as doenças', error: e, stackTrace: s);
      throw ExceptionErros(message: 'Erro ao relacionar as doenças');
    }
  }

  @override
  Future<List<ModeloDoenca>> listarDoenca() async {
    try {
      final result = await dio.unauth().get('/doenca');
      return result.data
          .map<ModeloDoenca>(
            (exe) => ModeloDoenca.fromMap(exe),
          )
          .toList();
    } on DioException catch (e, s) {
      log('Erro ao buscar a lista de doenças', error: e, stackTrace: s);
      throw ExceptionErros(message: 'Doenças indisponiveis');
    }
  }

//-------------------------------------dias-------------------------------------
  @override
  Future<void> relacionarUsuarioDiasTreino(List<int> dias) async {
    try {
      await dio.auth().post('/treino', data: dias);
    } on DioException catch (e, s) {
      log('Erro ao relacionar os treinos', error: e, stackTrace: s);
      throw ExceptionErros(message: 'Erro ao relacionar os treinos');
    }
  }

  @override
  Future<List<ModeloDiasTreino>> listarDiasTreino() async {
    try {
      final result = await dio.unauth().get('/usuario/treino');
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
