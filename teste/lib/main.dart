import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

void main() {
  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late WebSocketChannel channel;
  final TextEditingController _controller = TextEditingController();
  final List<String> messages = [];
  final String userId = "user1"; // Simulando um usuário logado
  final String receiverId = "user2"; // Destinatário

  @override
  void initState() {
    super.initState();
    // Conectar ao servidor WebSocket
    channel = WebSocketChannel.connect(Uri.parse("ws://localhost:3000"));

    // Enviar login para registrar o usuário no servidor
    channel.sink.add(jsonEncode({
      "type": "login",
      "userId": userId,
    }));

    // Ouvir mensagens do WebSocket
    channel.stream.listen((data) {
      final message = jsonDecode(data);
      setState(() {
        messages.add("${message['senderId']}: ${message['text']}");
      });
    });
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      // Enviar mensagem via WebSocket
      channel.sink.add(jsonEncode({
        "type": "message",
        "senderId": userId,
        "receiverId": receiverId,
        "text": _controller.text,
      }));

      // Adicionar à lista de mensagens locais
      setState(() {
        messages.add("Você: ${_controller.text}");
      });

      _controller.clear();
    }
  }

  @override
  void dispose() {
    channel.sink.close(status.goingAway);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Chat WebSocket")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(messages[index]),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: "Digite uma mensagem...",
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
