// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:activovo/src/error/repository_exception.dart';
import 'package:activovo/src/funtional_prog/either.dart';
import 'package:activovo/src/funtional_prog/nil.dart';
import 'package:activovo/src/models/model_disease.dart';
import 'package:activovo/src/models/model_user.dart';
import 'package:activovo/src/models/model_exercise.dart';

import 'package:activovo/src/repositories/repository_geral/user_type_repository.dart';
import 'package:activovo/src/restClient/rest_client.dart';
import 'package:dio/dio.dart';

class UserTypeRepositoryImpl implements UserTypeRepository {
  final RestClient restClient;
  UserTypeRepositoryImpl({
    required this.restClient,
  });
  @override
  Future<Either<RepositoryException, ModelUser>> getMyUserType() async {
    try {
      final Response response = await restClient.auth.get(
        '/users',
      );

      ModelUser user = ModelUser.fromMap(response.data);

      return Success(user);
    } on DioException catch (e, s) {
      log('Erro ao buscar dados do usuário', error: e, stackTrace: s);
      return Failure(
          RepositoryException(message: 'Erro ao buscar dados do usuário'));
    }
  }

  @override
  Future<Either<RepositoryException, List<ModelDisease>>> getDisease() async {
    try {
      final Response<List> response = await restClient.auth.get(
        '/training/days/doencas',
      );

      List<ModelDisease> disease =
          response.data?.map((e) => ModelDisease.fromMap(e)).toList() ?? [];

      return Success(disease);
    } on DioException catch (e, s) {
      log('INvalid JSON', error: e, stackTrace: s);
      throw Failure(Exception('Invalid'));
    } on ArgumentError catch (e, s) {
      log('Erro ao buscar doenças (Invalid JSON)', error: e, stackTrace: s);
      throw Failure(Exception('Invalid'));
    }
  }

  @override
  Future<Either<RepositoryException, List<ModelExercise>>> getExercise() async {
    try {
      DateTime now = DateTime.now();
      int day = now.weekday;

      String weekday = '';
      switch (day) {
        case 1:
          weekday = 'Seg';
        case 2:
          weekday = 'Ter';
        case 3:
          weekday = 'Qua';
        case 4:
          weekday = 'Qui';
        case 5:
          weekday = 'Sex';
        case 6:
          weekday = 'Ssb';
        case 7:
          weekday = 'Dom';
      }

      final Response<List> response =
          await restClient.auth.get('/training/$weekday');
      List<ModelExercise> exercise =
          response.data?.map((e) => ModelExercise.fromMap(e)).toList() ?? [];

      return Success(exercise);
    } on DioException catch (e, s) {
      log('INvalid JSON', error: e, stackTrace: s);
      throw Failure(Exception('Invalid'));
    } on ArgumentError catch (e, s) {
      log('Erro ao buscar doenças (Invalid JSON)', error: e, stackTrace: s);
      throw Failure(Exception('Invalid'));
    }
  }

  @override
  Future<Either<RepositoryException, List<ModelExercise>>>
      getExerciseVip() async {
    try {
      DateTime now = DateTime.now();
      int day = now.weekday;

      String weekday = '';
      switch (day) {
        case 1:
          weekday = 'Seg';
        case 2:
          weekday = 'Ter';
        case 3:
          weekday = 'Qua';
        case 4:
          weekday = 'Qui';
        case 5:
          weekday = 'Sex';
        case 6:
          weekday = 'Ssb';
        case 7:
          weekday = 'Dom';
      }

      final Response<List> response =
          await restClient.auth.get('/training/vip/$weekday');
      List<ModelExercise> exercise =
          response.data?.map((e) => ModelExercise.fromMap(e)).toList() ?? [];

      return Success(exercise);
    } on DioException catch (e, s) {
      log('INvalid JSON', error: e, stackTrace: s);
      throw Failure(Exception('Invalid'));
    } on ArgumentError catch (e, s) {
      log('Erro ao buscar doenças (Invalid JSON)', error: e, stackTrace: s);
      throw Failure(Exception('Invalid'));
    }
  }

  @override
  Future<Either<RepositoryException, Nil>> saveDays(
      ({List<String> days}) data) async {
    try {
      await restClient.auth.post('/training/days', data: {
        'user_id': '#userAuthRef',
        'days': data.days,
      });
      return Success(nil);
    } on DioException catch (e, s) {
      log('Erro ao criar treino sem doenças', error: e, stackTrace: s);
      return Failure(
          RepositoryException(message: 'Erro ao criar treino sem doenças'));
    }
  }

  @override
  Future<Either<RepositoryException, Nil>> saveDaysDisease(
      ({List<String> days, List<int> disease}) data) async {
    try {
      await restClient.auth.post('/training/days/doencas', data: {
        'user_id': '#userAuthRef',
        'days': data.days,
        'disease_id': data.disease,
      });
      return Success(nil);
    } on DioException catch (e, s) {
      log('Erro ao cadastrar treino com doenças', error: e, stackTrace: s);
      return Failure(
          RepositoryException(message: 'Erro ao criar treino sem doenças'));
    }
  }

  @override
  Future<Either<RepositoryException, Nil>> savePlanImprovements(
      ({List<String> improvement}) data) async {
    try {
      await restClient.auth.post('/planImprovements', data: {
        'user_id': '#userAuthRef',
        'improvements': data.improvement,
      });
      return Success(nil);
    } on DioException catch (e, s) {
      log('Erro ao cadastrar as melhoras do novo plano',
          error: e, stackTrace: s);
      return Failure(RepositoryException(
          message: 'Erro ao cadastrar as melhoras do novo plano'));
    }
  }

  @override
  Future<Either<RepositoryException, Nil>> modifyUser(
      ({String profile}) data) async {
    try {
      await restClient.auth.patch('/users', data: {
        'id': '#userAuthRef',
        'profile': 'VIP',
      });
      return Success(nil);
    } on DioException catch (e, s) {
      log('Erro ao modificar usuário', error: e, stackTrace: s);
      return Failure(RepositoryException(message: 'Erro ao modificar usuário'));
    }
  }
}
