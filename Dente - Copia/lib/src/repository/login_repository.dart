// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dente/core/exceptions/create_exception.dart';
import 'package:dente/core/exceptions/repository_exception.dart';
import 'package:dente/core/exceptions/unauthorized_exceptiom.dart';
// import 'package:dente/core/rest_client/rest_client.dart';
import 'package:dente/core/rest_client/rest_client.dart'
    if (dart.library.html) 'package:dente/core/rest_client/rest_client_web.dart';

import 'package:dente/src/models/empresa_model.dart';
import 'package:dio/dio.dart';

class LoginRepository {
  final RestClient restClient;
  LoginRepository({required this.restClient});

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await restClient.unauth.get(
        '/login',
        queryParameters: {'email': email, 'password': password},
      );
      return response.data;
    } on DioException catch (e) {
      e.response?.statusCode == 401
          ? {throw UnauthorizedExceptiom(e.response?.data['msg'])}
          : {throw RepositoryException(message: 'Erro ao realizar login')};
    }
  }

  Future<EmpresaModel> buscaInfoEmpresa() async {
    try {
      final response = await restClient.auth.get('/empresa/find');
      return EmpresaModel.fromMap(response.data);
    } on DioException catch (e) {
      throw CreateException.dioException(e);
    }
  }

  Future<Map<String, dynamic>> enviaEmailRedefineSenha(String email) async {
    try {
      final response = await restClient.unauth.get(
        '/redefine',
        queryParameters: {'email': email},
      );

      return response.data;
    } on DioException catch (e) {
      throw CreateException.dioException(e);
    }
  }
}
