import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:homechat/src/core/models/message_model.dart';
import 'package:homechat/src/pages/chat/chat_state.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

part 'chat_vm.g.dart';

@riverpod
class ChatVm extends _$ChatVm {
  final wsUrl = Uri.parse('ws://172.16.251.22:3001');
  late final channel = WebSocketChannel.connect(wsUrl);

  final msg = ValueNotifier<List<MessageModel>>([]);

  init() async {
    await channel.ready;

    channel.stream.listen(
      (message) {
        msg.value = List.from(msg.value)..add(MessageModel.fromMap(message));
      },
      onError: (error, stackTrae) {
        log('Error: ', error: error, stackTrace: stackTrae);
        log('Message: ', error: error.message);
      },
      onDone: () {
        log('Finalizado');
      },
      cancelOnError: true,
    );
  }

  sendMessage(int senderId, int receiverId, String text) {
    channel.sink.add(
        MessageModel(senderId: senderId, receiverId: receiverId, text: text)
            .toJson());
  }

  @override
  Future<ChatState> build() async {
    try {
      // Aqui você pode inicializar com uma lista vazia de mensagens.
      return ChatState(status: ChatStateStatus.initial, messages: []);
    } catch (e, s) {
      log('Erro: ', error: e, stackTrace: s);
      return ChatState(
        status: ChatStateStatus.error,
        messages: [],
        errorMessage: 'Erro ao carregar chat.',
      );
    }
  }
}
