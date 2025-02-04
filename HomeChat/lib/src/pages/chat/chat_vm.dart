import 'dart:developer';

import 'package:homechat/src/core/exceptions/repository_exception.dart';
import 'package:homechat/src/core/fp/either.dart';
import 'package:homechat/src/core/providers/application_provider.dart';
import 'package:homechat/src/pages/chat/chat_state.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chat_vm.g.dart';

@riverpod
class ChatVm extends _$ChatVm {
  @override
  Future<ChatState> build(receiverId) async {
    try {
      final repository = ref.read(repositoryMessagesProvider);

      final message = await repository.getMessages(receiverId);
      switch (message) {
        case Success(value: final message):
          return ChatState(status: ChatStateStatus.loaded, messages: message);
        case Failure():
          return ChatState(status: ChatStateStatus.error, messages: []);
      }
    } on Exception catch (e, s) {
      log('Erro: ', error: e, stackTrace: s);

      return throw RepositoryException(
        message: 'Erro ao buscar Messages',
      );
    }
  }

  Future<void> sendMessages(int senderId, int receiverId, String text) async {
    final repository = ref.read(repositoryMessagesProvider);
    final dto = (senderId: senderId, receiverId: receiverId, text: text);
    final result = await repository.sendMessages(dto);
    switch (result) {
      case true:
        // ref.invalidate(getMessagesProvider);
        ref.invalidate(repositoryMessagesProvider);
      case false:
        state = ChatStateStatus.error as AsyncValue<ChatState>;
    }
  }
}


// Future<void> addFriends(int userId) async {
//     final repository = ref.read(repositoryGeneralProvider);
//     final dto = (userId: userId);
//     final result = await repository.addRequest(dto);
//     switch (result) {
//       case Success():
//         ref.invalidate(getMeProvider);
//         ref.invalidate(repositoryGeneralProvider);

//       case Failure():
//         state = HomeStateStatus.error as AsyncValue<HomeState>;
//     }
//   }