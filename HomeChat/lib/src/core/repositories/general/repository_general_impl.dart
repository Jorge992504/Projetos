// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:homechat/src/core/client/res_client.dart';
import 'package:homechat/src/core/exceptions/repository_exception.dart';
import 'package:homechat/src/core/fp/either.dart';
import 'package:homechat/src/core/fp/nil.dart';

import 'package:homechat/src/core/models/user_model.dart';
import 'package:homechat/src/core/repositories/general/repository_general.dart';

class RepositoryGeneralImpl implements RepositoryGeneral {
  final RestClient restClient;

  RepositoryGeneralImpl({
    required this.restClient,
  });

  @override
  Future<Either<RepositoryException, List<UserModel>>> getUsers(
      List<UserModel> name) async {
    try {
      final Response<List> response = await restClient.auth.get('/user', data: {
        'id': '#userAuthRef',
      });
      List<UserModel> users =
          response.data?.map((e) => UserModel.fromMap(e)).toList() ?? [];
      return Success(users);
    } on DioException catch (e, s) {
      log('Error: ', error: e.error, stackTrace: s);
      throw Failure(Exception('Erro ao pesquisar usuário'));
    }
  }

  @override
  Future<Either<RepositoryException, Nil>> invitation(
      ({String email, String text}) data) async {
    try {
      await restClient.unauth.post('/email', data: {
        'email': data.email,
        'text': data.text,
      });
      return Success(nil);
    } on DioException catch (e, s) {
      log('Erro ao guardar e-mail', error: e.error, stackTrace: s);
      log('Message do erro: ', error: e.message);
      return Failure(RepositoryException(message: 'Erro ao guardar e-mail'));
    }
  }

  @override
  Future<Either<RepositoryException, Nil>> confirmCod(
      ({int codigo}) data) async {
    try {
      await restClient.auth.post('/confirm', data: {
        'codigo': data.codigo,
      });
      return Success(nil);
    } on DioException catch (e, s) {
      log('Erro ao verificar código', error: e.error, stackTrace: s);
      log('Message do erro: ', error: e.message);
      return Failure(RepositoryException(message: 'Erro ao verificar código'));
    }
  }

  @override
  Future<Either<RepositoryException, Nil>> addRequest(
      ({int userId}) data) async {
    try {
      await restClient.auth.post('/request', data: {
        'user_id': data.userId,
      });
      return Success(nil);
    } on DioException catch (e, s) {
      log('Erro ao enviar convite de amizade', error: e.error, stackTrace: s);
      log('Message do erro: ', error: e.message);
      return Failure(
          RepositoryException(message: 'Erro ao enviar convite de amizade'));
    }
  }

  @override
  Future<Either<RepositoryException, List<UserModel>>> getRequest() async {
    try {
      final Response<List> response = await restClient.auth.get('/request');
      List<UserModel> friend =
          response.data?.map((e) => UserModel.fromMap(e)).toList() ?? [];
      return Success(friend);
    } on DioException catch (e, s) {
      log('| Error: ', error: e.error, stackTrace: s);
      log('| Message do erro: ', error: e.message);
      log('|--------------------------------------------|');
      throw Failure(Exception('Erro ao buscar as solicitações de amizade'));
    }
  }

  @override
  Future<Either<RepositoryException, Nil>> aceptRequest(
      ({int friendId}) data) async {
    try {
      await restClient.auth.patch('/request', data: {
        'friend_id': data.friendId,
      });
      return Success(nil);
    } on DioException catch (e, s) {
      log('Erro ao aceptar a solicitação', error: e.error, stackTrace: s);
      log('Message do erro: ', error: e.message);
      return Failure(
          RepositoryException(message: 'Erro ao aceptar a solicitação'));
    }
  }

  @override
  Future<Either<RepositoryException, Nil>> deletRequest(
      ({int request}) data) async {
    try {
      await restClient.auth.delete('/request', data: {
        'request': data.request,
      });
      return Success(nil);
    } on DioException catch (e, s) {
      log('Erro ao deletar a solicitação', error: e.error, stackTrace: s);
      log('Message do erro: ', error: e.message);
      return Failure(
          RepositoryException(message: 'Erro ao deletar a solicitação'));
    }
  }

  @override
  Future<Either<RepositoryException, Nil>> deletFriend(
      ({int friendId}) data) async {
    try {
      await restClient.auth.delete('/friends', data: {
        'friend_id': data.friendId,
      });
      return Success(nil);
    } on DioException catch (e, s) {
      log('Erro ao deletar a solicitação', error: e.error, stackTrace: s);
      log('Message do erro: ', error: e.message);
      return Failure(
          RepositoryException(message: 'Erro ao deletar a solicitação'));
    }
  }

  @override
  Future<Either<RepositoryException, List<UserModel>>> getFriend() async {
    try {
      final Response<List> response = await restClient.auth.get('/friends');
      List<UserModel> friend =
          response.data?.map((e) => UserModel.fromMap(e)).toList() ?? [];
      return Success(friend);
    } on DioException catch (e, s) {
      log('| Error: ', error: e.error, stackTrace: s);
      log('| Message do erro: ', error: e.message);
      log('|--------------------------------------------|');
      throw Failure(Exception('Erro ao buscar as solicitações de amizade'));
    }
  }
}
