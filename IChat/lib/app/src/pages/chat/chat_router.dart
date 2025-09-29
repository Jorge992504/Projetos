import 'package:flutter/material.dart';
import 'package:ichat/app/src/pages/chat/chat_controller.dart';
import 'package:ichat/app/src/pages/chat/chat_page.dart';
import 'package:ichat/app/src/repository/chat_repository.dart';
import 'package:provider/provider.dart';

class ChatRouter {
  ChatRouter._();
  static Widget page() => MultiProvider(
    providers: [
      Provider<ChatRepository>(
        create: (context) => ChatRepository(restClient: context.read()),
      ),
      Provider<ChatController>(
        create: (context) => ChatController(context.read<ChatRepository>()),
      ),
    ],
    child: ChatPage(),
  );
}
