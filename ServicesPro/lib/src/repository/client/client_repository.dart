import 'package:dio/dio.dart';
import 'package:servicespro/core/exceptions/create_exception.dart';
import 'package:servicespro/core/exceptions/repository_exception.dart';
import 'package:servicespro/core/rest_client/rest_client.dart';
import 'package:servicespro/src/models/client/usuario_prestador/usuario_prestador_model.dart';

class ClientRepository {
  final RestClient restClient;
  ClientRepository({required this.restClient});

  Future<List<UsuarioPrestadorModel>> buscarPrestadorCategoria(
    int idCategoria,
  ) async {
    try {
      final response = await restClient.auth.get(
        '/prestador/buscar/categoria',
        queryParameters: {'idCategoria': idCategoria},
      );
      return response.data
          .map<UsuarioPrestadorModel>((e) => UsuarioPrestadorModel.fromMap(e))
          .toList();
    } on DioException catch (e) {
      e.response?.statusCode == 401 || e.response?.statusCode == 403
          ? {throw RepositoryException(message: "Problemas de conexão")}
          : throw CreateException.dioException(e);
    }
  }
}
