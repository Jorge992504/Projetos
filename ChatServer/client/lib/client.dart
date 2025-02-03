import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

void main() {
  // Solicitar o nome do usuário antes de conectar
  stdout.write('Digite seu nome: ');
  String? nomeUsuario = stdin.readLineSync();
  if (nomeUsuario == null || nomeUsuario.isEmpty) {
    nomeUsuario =
        'Usuário Anônimo'; // Defina um nome padrão se o usuário não fornecer um
  }

  // Gerar o token JWT com o nome do usuário no payload
  final secretKey = 'SECRET_KEY'; // Mantenha a mesma chave usada no servidor
  final jwt = JWT(
      {'id': 'client_id_123', 'name': nomeUsuario}); // Inclui o nome no payload
  final token = jwt.sign(SecretKey(secretKey));

  // Conectar ao servidor e enviar o token com o nome
  Socket socket = io(
    'http://localhost:2000',
    OptionBuilder()
        .setTransports(['websocket']).setAuth({'token': token}).build(),
  );

  // Conectar o cliente
  socket.onConnect((_) {
    print('Client id: ${socket.id}');
    socket.emit('chat message', 'Olá servidor!');
  });

  // Exibir lista de clientes conectados
  socket.on('clientsList', (data) {
    print('Clientes conectados:');
    for (var client in data) {
      print(client);
    }

    // Solicitar ao usuário para escolher um destinatário
    stdout.write(
        'Escolha um destinatário (ou pressione Enter para enviar para todos): ');
    String? recipient = stdin.readLineSync();
    if (recipient != null && recipient.isNotEmpty) {
      // Enviar para o cliente específico
      socket.emit(
        "sendMessage",
        {
          'senderId': socket.id,
          'senderName': nomeUsuario,
          'msg': recipient,
          'targetId': recipient, // Nome do destinatário escolhido
        },
      );
    } else {
      // Enviar para todos
      socket.emit(
        "sendMessage",
        {
          'senderId': socket.id,
          'senderName': nomeUsuario,
        },
      );
    }
  });

  // Tratar erros
  socket.on('connect_error', (data) {
    print('Erro de conexão: $data');
  });

  socket.on('receberMessage', (data) {
    String id = data['senderName'];
    String msg = data['msg'];
    print('$id: $msg');
  });

  // Enviar mensagens com o nome
  stdin.listen((data) {
    String input = String.fromCharCodes(data).toString();
    socket.emit(
      "sendMessage",
      {
        'senderId': socket.id,
        'senderName': nomeUsuario,
        'msg': input,
      },
    );
  });
  socket.onDisconnect((_) {
    print('Desconectado do servidor');
  });
  Timer.periodic(Duration(seconds: 5), (_) => socket.emit("custom_disconnect"));
}
