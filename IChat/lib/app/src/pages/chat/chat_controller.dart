import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:ichat/app/core/exceptions/repository_exception.dart';
import 'package:ichat/app/src/models/messages_model.dart';
import 'package:ichat/app/src/models/path_message_model_request.dart';
import 'package:ichat/app/src/pages/chat/chat_state.dart';
import 'package:ichat/app/src/repository/chat_repository.dart';

class ChatController extends Cubit<ChatState> {
  final ChatRepository _repository;

  ChatController(this._repository) : super(ChatState.initial());

  Future<void> buscaMessages(String userFrom) async {
    try {
      emit(state.copyWith(status: ChatStatus.loading, messages: []));

      final response = await _repository.buscaMessages(userFrom);

      emit(state.copyWith(status: ChatStatus.loaded, messages: response));
    } on RepositoryException catch (e, s) {
      log('$e\n$s');
      emit(
        state.copyWith(
          status: ChatStatus.error,
          errorMessage: "Erro no controller: ${e.message}\nTrace: $s",
          messages: [],
        ),
      );
    }
  }

  Future<PathMessageModelRequest?> salvaMessages(MessagesModel messages) async {
    try {
      emit(state.copyWith(status: ChatStatus.loading));

      final response = await _repository.salvaMessages(messages);

      emit(state.copyWith(status: ChatStatus.loaded));
      return response;
    } on RepositoryException catch (e, s) {
      emit(
        state.copyWith(
          status: ChatStatus.error,
          errorMessage: "e.message}\nTrace: $s",
        ),
      );
      return PathMessageModelRequest();
    }
  }

  Future<void> addMessage(MessagesModel message) async {
    emit(state.copyWith(status: ChatStatus.loading, messages: state.messages));
    // Mantém as mensagens existentes e adiciona a nova
    final updatedMessages = List<MessagesModel>.from(state.messages ?? [])
      ..add(message);

    // Emite o novo estado com a lista atualizada
    emit(state.copyWith(messages: updatedMessages, status: ChatStatus.loaded));
  }
}
