import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// ignore: library_prefixes
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketClient with ChangeNotifier {
  IO.Socket? socket;
  bool isConnect = false;

  Future<void> connect() async {
    final sp = await SharedPreferences.getInstance();
    final token = sp.getString('token');
    if (token == null) {
      return;
    }

    socket = IO.io(
        'http://172.16.251.22:4000',
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .enableAutoConnect()
            .setExtraHeaders({'Authorization': 'Bearer $token'})
            .build());

    socket?.onConnect((_) {
      log('Conectado ao servidor');
      isConnect = true;
      notifyListeners();
    });

    socket?.onDisconnect((_) async {
      log('Desconectado do servidor');

      isConnect = false;

      notifyListeners();
    });

    socket?.connect();
  }

  bool sendMessage(Map<String, dynamic> msg) {
    if (isConnect == true) {
      socket?.emit("mensagem", msg);
      return true;
    } else {
      return false;
    }
  }

  bool disconnect(bool disconnect) {
    if (disconnect == true) {
      socket?.disconnect();
      socket?.emit('Ondisconnect');
      return true;
    } else {
      return false;
    }
  }

  void listenMessageReceiver(
      Function(Map<String, dynamic> msg) onMessageReceiver) {
    socket?.on("mensagem", (msg) {
      onMessageReceiver(msg);
      notifyListeners();
    });
    notifyListeners();
  }
}
