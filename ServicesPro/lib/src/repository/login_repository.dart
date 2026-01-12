// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:servicespro/core/exceptions/create_exception.dart';
import 'package:servicespro/core/exceptions/repository_exception.dart';
import 'package:servicespro/core/exceptions/unauthorized_exceptiom.dart';
import 'package:servicespro/core/rest_client/rest_client.dart';
import 'package:servicespro/src/dto/response/response_token.dart';
import 'package:servicespro/src/models/usuario_model.dart';

class LoginRepository {
  final RestClient restClient;
  LoginRepository({required this.restClient});

  Future<ResponseToken> login(String email, String password) async {
    try {
      final response = await restClient.unauth.get(
        '/auth/login',
        queryParameters: {'email': email, 'password': password},
      );
      return ResponseToken.fromMap(response.data);
    } on DioException catch (e) {
      e.response?.statusCode == 401
          ? {throw UnauthorizedExceptiom(e.response?.data['message'])}
          : {throw RepositoryException(message: 'Erro ao realizar login')};
    }
  }

  Future<bool> validarToken() async {
    try {
      await restClient.auth.get("/controller/valid/token");
      return true;
    } on DioException catch (e) {
      log("Erro: $e");
      return false;
    }
  }

  Future<UsuarioModel> buscaDadosUsuario() async {
    try {
      final response = await restClient.auth.get("/user/search/info");
      return UsuarioModel.fromMap(response.data);
    } on DioException catch (e) {
      throw CreateException.dioException(e);
    }
  }
}
