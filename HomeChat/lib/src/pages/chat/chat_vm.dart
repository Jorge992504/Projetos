import 'package:homechat/src/core/fp/either.dart';
import 'package:homechat/src/core/providers/application_provider.dart';
import 'package:homechat/src/pages/chat/chat_state.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chat_vm.g.dart';

@riverpod
class ChatVm extends _$ChatVm {
  @override
  Future<ChatState> build(receiverId) async {
    final repository = ref.read(repositoryMessagesProvider);

    final message = await repository.getMessages(receiverId);
    switch (message) {
      case Success(value: final message):
        return ChatState(status: ChatStateStatus.loaded, messages: message);
      case Failure():
        return ChatState(status: ChatStateStatus.error, messages: []);
    }
  }
}
