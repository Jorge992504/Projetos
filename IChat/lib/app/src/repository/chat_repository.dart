import 'package:ichat/app/core/exceptions/create_exception.dart';
import 'package:ichat/app/core/rest_client/rest_client.dart';
import 'package:ichat/app/src/models/messages_model.dart';

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
    } catch (e) {
      throw CreateException.dioException(e);
    }
  }

  Future<bool> salvaMessages(MessagesModel messages) async {
    try {
      await restClient.auth.post(
        '/messages/send',
        data: {
          'senderEmail': messages.userTo,
          'receiverEmail': messages.userFrom,
          'message': messages.message,
        },
      );

      return true;
    } catch (e) {
      throw CreateException.dioException(e);
    }
  }
}
