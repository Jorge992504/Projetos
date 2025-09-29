import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ichat/app/core/exceptions/repository_exception.dart';
import 'package:ichat/app/src/models/message_dto_request.dart';
import 'package:ichat/app/src/models/messages_model.dart';
import 'package:web_socket_channel/io.dart';

class WebSocketProvider extends ChangeNotifier {
  final String usuarioLogado;

  String url;
  late IOWebSocketChannel _channel;
  final List<MessagesModel> messagens = [];
  bool _conectado = false;

  WebSocketProvider({required this.usuarioLogado})
    : url = "ws://172.16.251.22:8082/api/chat" {
    // conectar();
  }

  bool get conectado => _conectado;

  Future<void> conectar() async {
    try {
      _channel = IOWebSocketChannel.connect(
        Uri.parse(url),
        headers: {'Authorization': usuarioLogado},
      );

      _channel.stream.asBroadcastStream().listen(
        (event) {
          Map<String, dynamic> response = jsonDecode(event);
          log(response.toString());
          if (response["status"] == "connected") {
            _conectado = true;
          } else {
            final message = MessagesModel(
              userTo: response['userReceiver'],
              message: response['message'],
              userFrom: response['userSender'],
              sentAt: DateTime.now(),
            );
            messagens.add(message);
            notifyListeners();
          }
        },
        onError: (error) {
          _conectado = false;
          log("Erro na conexão do WebSocket: $error");
          notifyListeners();
        },
        onDone: () {
          _conectado = false;
          log("Conexão do WebSocket encerrada");
          Future.delayed(const Duration(seconds: 5), conectar);
          notifyListeners();
        },
      );
    } on RepositoryException catch (e) {
      _conectado = false;
      RepositoryException(
        message:
            "Erro ao conectar o usuário: $usuarioLogado, Erro: ${e.message}",
      );
      notifyListeners();
    }
  }

  Future<bool> enviarMessagens(String userFrom, String messsage) async {
    if (_channel.closeCode == null) {
      MessageDtoRequest messageDtoRequest = MessageDtoRequest(
        userReceiver: userFrom,
        message: messsage,
      );
      _channel.sink.add(messageDtoRequest.toJson());
      MessagesModel message = MessagesModel(
        userTo: userFrom,
        userFrom: usuarioLogado,
        message: messsage,
        sentAt: DateTime.now(),
      );
      messagens.add(message);
      return true;
    } else {
      return false;
    }
  }

  void desconectar() {
    _channel.sink.close();
    _conectado = false;
    notifyListeners();
  }
}
