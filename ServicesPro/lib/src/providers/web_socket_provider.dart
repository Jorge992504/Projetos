// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:servicespro/src/models/message_model.dart';
import 'package:web_socket_channel/io.dart';

import 'package:servicespro/core/env/env.dart';
import 'package:servicespro/src/models/request_message_model.dart';
import 'package:servicespro/src/providers/auth_provider.dart';

class WebSocketProvider extends ChangeNotifier {
  IOWebSocketChannel? _channel;

  final List<MessageModel> _messages = [];
  bool _conetado = false;
  final AuthProvider authProvider;

  WebSocketProvider({required this.authProvider});
  bool get conetado => _conetado;
  List<MessageModel> get messages => _messages;

  Future<bool> conectar() async {
    _channel = IOWebSocketChannel.connect(
      Env.env["backend_chat_url"] ?? "",
      headers: {"Authorization": "Bearer ${authProvider.token}"},
    );
    _channel?.stream.asBroadcastStream().listen(
      (event) {
        log("event init");
        Map<String, dynamic> response = jsonDecode(event);
        log(response.toString());
        if (response["status"] == "connected") {
          _conetado = true;
        } else {
          receberMessages(response);
        }
      },
      onError: (_) {
        log("event error");
        _conetado = false;
        notifyListeners();
      },
      onDone: () {
        log("event Done");
        _conetado = false;
        Future.delayed(const Duration(seconds: 5), conectar);
        notifyListeners();
      },
    );
    return _conetado;
  }

  void receberMessages(Map<String, dynamic> json) {
    MessageModel response = MessageModel(
      usuarioFrom: json["usuarioFrom"],
      message: json["message"],
      isMe: false,
    );
    _messages.add(response);
    notifyListeners();
  }

  Future<bool> sendMessage(int usuarioTo, String message, String foto) async {
    if (_channel != null && _channel?.closeCode == null) {
      RequestMessageModel messageModel = RequestMessageModel(
        usuarioTo: usuarioTo,
        message: message,
        foto: foto,
      );
      _channel?.sink.add(messageModel.toJson());
      MessageModel model = MessageModel(
        message: messageModel.message,
        usuarioTo: messageModel.usuarioTo,
        isMe: true,
        foto: foto,
      );
      _messages.add(model);
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  List<MessageModel> atualizarLista(List<MessageModel> messageBD) {
    _messages == messageBD;
    return _messages;
  }

  Future<void> limparMensagens() async {
    _messages.clear();
    notifyListeners();
  }

  void desconectar() {
    _channel?.sink.close();
    _conetado = false;
    _channel = null; // <- evita LateInitializationError depois
    notifyListeners();
  }
}
