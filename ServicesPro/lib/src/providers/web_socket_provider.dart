// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

import 'package:servicespro/core/env/env.dart';
import 'package:servicespro/src/models/request_message_model.dart';
import 'package:servicespro/src/providers/auth_provider.dart';

class WebSocketProvider extends ChangeNotifier {
  IOWebSocketChannel? _channel;

  final List<RequestMessageModel> messages = [];
  bool _conetado = false;
  final AuthProvider authProvider;

  WebSocketProvider({required this.authProvider});
  bool get conetado => _conetado;

  Future<bool> conectar() async {
    _channel = IOWebSocketChannel.connect(
      Env.env["backend_chat_url"] ?? "",
      headers: {"Authorization": "Bearer ${authProvider.token}"},
    );
    _channel?.stream.asBroadcastStream().listen(
      (event) {
        Map<String, dynamic> response = jsonDecode(event);
        if (response["status"] == "connected") {
          _conetado = true;
        }
      },
      onError: (_) {
        _conetado = false;
        notifyListeners();
      },
      onDone: () {
        _conetado = false;
        Future.delayed(const Duration(seconds: 5), conectar);
        notifyListeners();
      },
    );
    return _conetado;
  }

  Future<void> receberMessages() async {
    _channel?.stream.asBroadcastStream().listen((event) {
      Map<String, dynamic> json = jsonDecode(event);
      final response = RequestMessageModel(
        usuarioFrom: json["usuarioFrom"],
        usuarioTo: json["usuarioTo"],
        message: json["message"],
      );
      messages.add(response);
      notifyListeners();
    });
  }

  Future<bool> sendMessage(int usuarioTo, String message) async {
    if (_channel != null && _channel?.closeCode == null) {
      RequestMessageModel messageModel = RequestMessageModel(
        usuarioTo: usuarioTo,
        message: message,
      );
      _channel?.sink.add(messageModel.toJson());
      RequestMessageModel model = RequestMessageModel(
        usuarioFrom: messageModel.usuarioFrom,
        message: messageModel.message,
        usuarioTo: messageModel.usuarioTo,
      );
      messages.add(model);
      return true;
    } else {
      return false;
    }
  }

  Future<void> limparMensagens() async {
    messages.clear();
    notifyListeners();
  }

  void desconectar() {
    _channel?.sink.close();
    _conetado = false;
    _channel = null; // <- evita LateInitializationError depois
    notifyListeners();
  }
}
