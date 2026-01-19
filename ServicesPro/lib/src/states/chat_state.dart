import 'package:servicespro/src/models/message_model.dart';

sealed class ChatState {
  const ChatState();

  bool get isInitial => this is ChatInitial;
  bool get isConnecting => this is ChatConnecting;
  bool get isConnected => this is ChatConnected;
  bool get isDisconnected => this is ChatDisconnected;
  bool get isReconnected => this is ChatReconnected;
  bool get isFailure => this is ChatFailure;
  bool get isLoaded => this is ChatLoaded;
  bool get isLoading => this is ChatLoading;
  bool get isChatMessageReceived => this is ChatMessageReceived;
}

class ChatInitial extends ChatState {
  const ChatInitial();
}

class ChatConnecting extends ChatState {
  const ChatConnecting();
}

class ChatLoaded extends ChatState {
  ChatLoaded();
}

class ChatLoading extends ChatState {
  const ChatLoading();
}

class ChatConnected extends ChatState {
  ChatConnected();
}

class ChatMessageReceived extends ChatState {
  final List<MessageModel> messages;
  ChatMessageReceived(this.messages);
}

class ChatDisconnected extends ChatState {
  const ChatDisconnected();
}

class ChatReconnected extends ChatState {
  const ChatReconnected();
}

class ChatFailure extends ChatState {
  final String? errorMessage;

  const ChatFailure({this.errorMessage});
}
