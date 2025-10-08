import 'package:dente/core/exceptions/create_exception.dart';
import 'package:dente/core/rest_client/rest_client.dart';
import 'package:dio/dio.dart';

class ResetPasswordRepository {
  final RestClient restClient;
  ResetPasswordRepository({required this.restClient});

  Future<void> enviaEmailRedefineSenha(String email) async {
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

  Future<void> verificaCodigo(int codigo, String email) async {
    try {
      final response = await restClient.unauth.post(
        '/redefine',
        data: {'codigo': codigo, 'email': email},
      );

      return response.data;
    } on DioException catch (e) {
      throw CreateException.dioException(e);
    }
  }

  Future<void> redefinirSenha(String password, String email) async {
    try {
      await restClient.unauth.post(
        '/redefine/password',
        data: {'password': password, 'email': email},
      );
    } on DioException catch (e) {
      throw CreateException.dioException(e);
    }
  }
}
