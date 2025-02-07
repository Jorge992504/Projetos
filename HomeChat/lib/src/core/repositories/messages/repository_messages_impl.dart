import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:homechat/src/core/client/res_client.dart';
import 'package:homechat/src/core/exceptions/repository_exception.dart';
import 'package:homechat/src/core/fp/either.dart';
import 'package:homechat/src/core/models/message_model.dart';
import 'package:homechat/src/core/repositories/messages/repository_messages.dart';

class RepositoryMessagesImpl implements RepositoryMessages {
  // final WebSocketClient channel;
  final RestClient restClient;

  RepositoryMessagesImpl({
    // required this.channel,
    required this.restClient,
  });

  @override
  Future<Either<RepositoryException, List<MessageModel>>> getMessages(
      int receivarId) async {
    try {
      final Response<List> response =
          await restClient.auth.get('/messages', data: {
        'id': '#userAuthRef',
        'receiverId': receivarId,
      });
      List<MessageModel> messages =
          response.data?.map((e) => MessageModel.fromMap(e)).toList() ?? [];
      return Success(messages);
    } on DioException catch (e, s) {
      log('Error: ', error: e.error, stackTrace: s);
      throw Failure(Exception('Erro ao pesquisar usuário'));
    }
  }
}
