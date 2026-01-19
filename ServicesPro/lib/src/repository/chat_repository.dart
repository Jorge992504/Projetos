import 'package:dio/dio.dart';
import 'package:servicespro/core/exceptions/create_exception.dart';
import 'package:servicespro/core/exceptions/repository_exception.dart';
import 'package:servicespro/core/rest_client/rest_client.dart';
import 'package:servicespro/src/models/message_model.dart';

class ChatRepository {
  final RestClient restClient;
  ChatRepository({required this.restClient});

  Future<List<MessageModel>> buscarMessages(int usuarioTo) async {
    try {
      final response = await restClient.auth.get(
        '/messages/buscar',
        queryParameters: {'usuarioTo': usuarioTo},
      );
      return response.data
          .map<MessageModel>((e) => MessageModel.fromMap(e))
          .toList();
    } on DioException catch (e) {
      e.response?.statusCode == 401 || e.response?.statusCode == 403
          ? {throw RepositoryException(message: "Problemas de conexão")}
          : throw CreateException.dioException(e);
    }
  }

  Future<Map<String, dynamic>> salvarMessage(MessageModel messageModel) async {
    try {
      final response = await restClient.auth.post(
        '/messages/salvar',
        data: messageModel.toJson(),
      );
      return response.data;
    } on DioException catch (e) {
      e.response?.statusCode == 401 || e.response?.statusCode == 403
          ? {throw RepositoryException(message: "Problemas de conexão")}
          : throw CreateException.dioException(e);
    }
  }
}
