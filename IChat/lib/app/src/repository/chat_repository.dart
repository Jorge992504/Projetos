import 'dart:developer';

import 'package:ichat/app/core/exceptions/create_exception.dart';
import 'package:ichat/app/core/rest_client/rest_client.dart';
import 'package:ichat/app/src/models/messages_model.dart';
import 'package:ichat/app/src/models/path_message_model_request.dart';

class ChatRepository {
  final RestClient restClient;
  ChatRepository({required this.restClient});

  Future<List<MessagesModel>> buscaMessages(String userFrom) async {
    try {
      final response = await restClient.auth.get(
        '/messages',
        queryParameters: {'userFrom': userFrom},
      );

      return response.data
          .map<MessagesModel>((m) => MessagesModel.fromMap(m))
          .toList();
    } catch (e, s) {
      log("Erro no repo: $e\n Trace: $s");
      throw CreateException.dioException(e);
    }
  }

  Future<PathMessageModelRequest?> salvaMessages(MessagesModel messages) async {
    try {
      log('--------------------> repos --> ${messages.toJson()}');
      final response = await restClient.auth.post(
        '/messages/send',
        data: {
          'senderEmail': messages.userTo,
          'receiverEmail': messages.userFrom,
          'message': messages.message,
          'isPick': messages.isPick,
          'image': messages.image,
        },
      );

      return PathMessageModelRequest.fromJson(response.data);
    } catch (e, s) {
      log("Erro no repo: $e\n Trace: $s");
      throw CreateException.dioException(e);
    }
  }
}
