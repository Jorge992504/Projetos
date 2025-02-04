import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:homechat/src/core/interceptors/auth_interceptor.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

final class RestClient extends DioForNative {
  RestClient()
      : super(
          BaseOptions(
            baseUrl: 'http://172.16.251.22:3000',
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 60),
            contentType: ContentType.json.value,
          ),
        ) {
    interceptors.addAll([
      LogInterceptor(
        requestBody: true,
        responseBody: true,
      ),
      AuthInterceptor(),
    ]);
  }
  RestClient get auth {
    options.extra['DIO_AUTH_KEY'] = true;
    return this;
  }

  RestClient get unauth {
    options.extra['DIO_AUTH_KEY'] = false;
    return this;
  }
}

final class WebSocketClient {
  final String url;
  late WebSocketChannel _channel;
  bool _isConnected = false;

  WebSocketClient({required this.url}) {
    _connect();
  }

  void _connect() {
    _channel = WebSocketChannel.connect(Uri.parse(url));
    _isConnected = true;
    debugPrint('WebSocket conectado: $url');

    _channel.stream.listen(
      (message) {
        debugPrint('Mensagem recebida: $message');
      },
      onDone: () {
        _isConnected = false;
        debugPrint('Conexão WebSocket encerrada');
      },
      onError: (error) {
        _isConnected = false;
        debugPrint('Erro no WebSocket: $error');
      },
    );
  }

  void sendMessage(Map<String, dynamic> message) {
    if (_isConnected) {
      _channel.sink.add(jsonEncode(message));
    } else {
      debugPrint('Não conectado ao WebSocket.');
    }
  }

  void close() {
    _channel.sink.close();
  }

  bool get isConnected => _isConnected;
}
