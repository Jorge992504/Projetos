import 'package:ichat/app/core/exceptions/create_exception.dart';
import 'package:ichat/app/core/rest_client/rest_client.dart';
import 'package:ichat/app/src/models/messages_model.dart';
import 'package:ichat/app/src/models/messages_of_user_model.dart';

class HomeRepository {
  final RestClient restClient;
  HomeRepository({required this.restClient});

  Future<List<MessagesOfUserModel>> buscaMessagesOfUSer() async {
    try {
      final response = await restClient.auth.get('/messages/ofuser');

      return response.data
          .map<MessagesOfUserModel>((m) => MessagesOfUserModel.fromMap(m))
          .toList();
    } catch (e) {
      throw CreateException.dioException(e);
    }
  }

  Future<List<MessagesModel>> buscaMessages(String userFrom) async {
    try {
      final response = await restClient.auth.get(
        '/messages',
        data: {'userFrom': userFrom},
      );

      return response.data
          .map<MessagesModel>((m) => MessagesModel.fromMap(m))
          .toList();
    } catch (e) {
      throw CreateException.dioException(e);
    }
  }
}
