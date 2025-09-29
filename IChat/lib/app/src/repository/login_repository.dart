import 'package:dio/dio.dart';
import 'package:ichat/app/core/exceptions/repository_exception.dart';
import 'package:ichat/app/core/exceptions/unauthorized_exceptiom.dart';
import 'package:ichat/app/core/rest_client/rest_client.dart';
import 'package:ichat/app/src/models/usuario_model.dart';

class LoginRepository {
  final RestClient restClient;
  LoginRepository({required this.restClient});

  Future<String> login(String email, String password) async {
    try {
      final response = await restClient.unauth.post(
        '/login',
        data: {'email': email, 'password': password},
      );

      return response.data['token'];
    } on DioException catch (e) {
      e.response?.statusCode == 403
          ? throw UnauthorizedExceptiom(
              e.response?.data['message'] ?? 'Unauthorized',
            )
          : throw RepositoryException(
              message: e.response?.data['message'] ?? 'Erro ao realizar login',
            );
    }
  }

  Future<bool> validateToken(String token) async {
    try {
      final response = await restClient.auth.get(
        '/validate_token',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      return response.data['isValid'];
    } on DioException catch (e) {
      e.response?.statusCode == 403
          ? throw UnauthorizedExceptiom(
              e.response?.data['message'] ?? 'Unauthorized',
            )
          : throw RepositoryException(
              message: e.response?.data['message'] ?? 'Erro ao validar token',
            );
    }
  }

  Future<UsuarioModel> getUsuarioByEmail() async {
    try {
      final response = await restClient.auth.get('/usuario');

      return UsuarioModel.fromMap(response.data);
    } on DioException catch (e) {
      e.response?.statusCode == 403
          ? throw UnauthorizedExceptiom(
              e.response?.data['message'] ?? 'Erro ao buscar usuário',
            )
          : throw RepositoryException(
              message: e.response?.data['message'] ?? 'Erro ao buscar usuário',
            );
    }
  }
}
