import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:servicespro/src/controllers/chat_controller.dart';
import 'package:servicespro/src/pages/chat_screen.dart';
import 'package:servicespro/src/providers/web_socket_provider.dart';
import 'package:servicespro/src/repository/chat_repository.dart';

class ChatRouter {
  ChatRouter._();
  static Widget page() => MultiProvider(
    providers: [
      Provider<ChatRepository>(
        create: (context) => ChatRepository(restClient: context.read()),
      ),
      Provider<ChatController>(
        create: (context) => ChatController(
          context.read<WebSocketProvider>(),
          context.read<ChatRepository>(),
        ),
      ),
    ],
    child: const ChatScreen(),
  );
}
