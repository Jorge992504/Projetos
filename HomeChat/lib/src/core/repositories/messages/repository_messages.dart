import 'package:homechat/src/core/exceptions/repository_exception.dart';
import 'package:homechat/src/core/fp/either.dart';
import 'package:homechat/src/core/models/message_model.dart';

abstract interface class RepositoryMessages {
  // Future<bool> sendMessages(({int senderId, int receiverId, String text}) data);
  Future<Either<RepositoryException, List<MessageModel>>> getMessages(
      int receiverId);
}
