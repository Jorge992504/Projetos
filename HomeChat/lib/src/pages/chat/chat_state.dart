// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:homechat/src/core/models/message_model.dart';

enum ChatStateStatus {
  loaded,
  error,
  sending,
  initial,
}

class ChatState {
  final ChatStateStatus status;
  final List<MessageModel> messages;
  final String? errorMessage;

  ChatState({
    required this.status,
    required this.messages,
    this.errorMessage,
  });

  ChatState copyWith({
    ChatStateStatus? status,
    List<MessageModel>? messages,
    String? errorMessage,
  }) {
    return ChatState(
      status: status ?? this.status,
      messages: messages ?? this.messages,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
