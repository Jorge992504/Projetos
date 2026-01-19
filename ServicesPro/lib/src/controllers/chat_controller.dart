import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:servicespro/core/exceptions/repository_exception.dart';
import 'package:servicespro/src/models/message_model.dart';
import 'package:servicespro/src/providers/web_socket_provider.dart';
import 'package:servicespro/src/repository/chat_repository.dart';
import 'package:servicespro/src/states/chat_state.dart';

class ChatController extends Cubit<ChatState> {
  final WebSocketProvider _webSocketProvider;
  final ChatRepository _chatRepository;

  ChatController(this._webSocketProvider, this._chatRepository)
    : super(ChatInitial());

  void conectar() {
    emit(ChatConnecting());
    _webSocketProvider.conectar();
    emit(ChatConnected());
  }

  Future<bool> enviarMensagem(
    int usuarioTo,
    String message,
    String foto,
  ) async {
    try {
      emit(ChatLoading());
      final response = await _webSocketProvider.sendMessage(
        usuarioTo,
        message,
        foto,
      );
      emit(ChatLoaded());
      return response;
    } on RepositoryException catch (e) {
      emit(ChatFailure(errorMessage: e.message));
      return false;
    }
  }

  void atualizarMessages(BuildContext context) {
    emit(ChatLoading());
    final response = Provider.of<WebSocketProvider>(
      context,
      listen: false,
    ).messages;
    emit(ChatMessageReceived(response));
  }

  void desconectar() {
    emit(ChatLoading());
    _webSocketProvider.desconectar();
    emit(ChatDisconnected());
  }

  Future<List<MessageModel>> buscarMessages(int usuarioTo) async {
    try {
      emit(ChatInitial());
      final response = await _chatRepository.buscarMessages(usuarioTo);
      emit(ChatLoaded());
      return response;
    } on RepositoryException catch (e) {
      emit(ChatFailure(errorMessage: e.message));
      return [];
    }
  }

  Future<Map<String, dynamic>> salvarMessages(MessageModel messageModel) async {
    try {
      emit(ChatInitial());
      final response = await _chatRepository.salvarMessage(messageModel);
      emit(ChatLoaded());
      return response;
    } on RepositoryException catch (e) {
      emit(ChatFailure(errorMessage: e.message));
      return {};
    }
  }
}
