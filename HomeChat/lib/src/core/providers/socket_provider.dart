import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:homechat/src/core/models/message_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SocketProvider extends ChangeNotifier {
  final List<MessageModel> _mensagens = [];
  final Socket _socket;

  List<MessageModel> get mensagens => _mensagens;
  bool get isConnect => _socket.connected;

  SocketProvider({required Socket socket}) : _socket = socket {
    if (!_socket.connected) {
      _socket.connect();
    }
    _socket.onConnect(onConnect);
    _socket.onDisconnect(onDisconnect);
    _socket.on("mensagem", receiverMessage);
  }

  void onConnect(_) {
    log('Conectado ao servidor');
    notifyListeners();
  }

  onDisconnect(_) async {
    log('Desconectado do servidor');
    notifyListeners();
  }

  bool sendMessage(Map<String, dynamic> msg) {
    if (isConnect == true) {
      _socket.emit("mensagem", msg);
      return true;
    } else {
      return false;
    }
  }

  void receiverMessage(dynamic msg) {
    _mensagens.add(MessageModel.fromMap(msg));
    notifyListeners();
  }

  void listenMessageReceiver(
      Function(Map<String, dynamic> msg) onMessageReceiver) {
    _socket.on("mensagem", (msg) {
      onMessageReceiver(msg);
      notifyListeners();
    });
    notifyListeners();
  }

  static SocketProvider create() {
    final sp = SharedPreferencesAsync();
    final token = sp.getString('token');
    final socket = io(
        'http://172.16.251.22:4000',
        OptionBuilder()
            .setTransports(['websocket'])
            .enableAutoConnect()
            .setExtraHeaders({'Authorization': 'Bearer $token'})
            .build());
    return SocketProvider(socket: socket);
  }
}
