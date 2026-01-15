import 'package:dio/dio.dart';
import 'package:servicespro/core/exceptions/create_exception.dart';
import 'package:servicespro/core/exceptions/repository_exception.dart';
import 'package:servicespro/core/rest_client/rest_client.dart';
import 'package:servicespro/src/dto/response/response_token.dart';
import 'package:servicespro/src/models/categorias_model.dart';
import 'package:servicespro/src/models/usuario_model.dart';

class RegisterRepository {
  final RestClient restClient;
  RegisterRepository({required this.restClient});

  Future<ResponseToken> registrarUsuario(UsuarioModel usuarioModel) async {
    try {
      final response = await restClient.unauth.post(
        '/auth/register',
        data: usuarioModel.toJson(),
      );
      return ResponseToken.fromMap(response.data);
    } on DioException catch (e) {
      e.response?.statusCode == 401
          ? {throw RepositoryException(message: "Problemas de conexão")}
          : throw CreateException.dioException(e);
    }
  }

  Future<List<CategoriasModel>> buscarCategorias() async {
    try {
      final response = await restClient.auth.get('/categorias/buscar');
      return response.data
          .map<CategoriasModel>((e) => CategoriasModel.fromMap(e))
          .toList();
    } on DioException catch (e) {
      e.response?.statusCode == 401 || e.response?.statusCode == 403
          ? {throw RepositoryException(message: "Problemas de conexão")}
          : throw CreateException.dioException(e);
    }
  }

  Future<void> registrarInfosUsuario(UsuarioModel usuarioModel) async {
    try {
      await restClient.auth.post(
        '/auth/register/completar',
        data: usuarioModel.toJson(),
      );
    } on DioException catch (e) {
      e.response?.statusCode == 401
          ? {throw RepositoryException(message: "Problemas de conexão")}
          : throw CreateException.dioException(e);
    }
  }
}
