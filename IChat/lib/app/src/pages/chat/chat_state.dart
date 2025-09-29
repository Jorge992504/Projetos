import 'package:ichat/app/src/models/messages_model.dart';
import 'package:match/match.dart';

part 'chat_state.g.dart';

@match
enum ChatStatus { initial, loading, loaded, send, error }

class ChatState {
  final ChatStatus status;
  final String? errorMessage;
  final List<MessagesModel>? messages;
  ChatState.initial()
    : status = ChatStatus.initial,
      errorMessage = null,
      messages = [];
  ChatState({required this.status, this.errorMessage, this.messages});
  ChatState copyWith({
    ChatStatus? status,
    String? errorMessage,
    List<MessagesModel>? messages,
  }) {
    return ChatState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      messages: messages ?? this.messages,
    );
  }

  List<Object?> get props => [status, errorMessage, messages];
}
