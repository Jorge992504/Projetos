import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:homechat/src/core/models/message_model.dart';
import 'package:homechat/src/core/models/user_model.dart';
import 'package:homechat/src/core/providers/application_provider.dart';
import 'package:homechat/src/pages/chat/chat_state.dart';
import 'package:homechat/src/pages/chat/chat_vm.dart';
import 'package:homechat/src/pages/chat/widgets/message_text_field.dart';
import 'package:homechat/src/ui/helpers/messages.dart';

class ChatPage extends ConsumerStatefulWidget {
  const ChatPage({super.key});

  @override
  ConsumerState<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  final channel = ChatVm();
  final messageEC = TextEditingController();
  List<MessageModel> messages = [];

  @override
  void initState() {
    super.initState();
    // print("--------------------msg> ");
    ref.read(socketProvider).socket?.on("mensagem", (msg) {
      setState(() {
        messages.add(MessageModel.fromMap(msg));
      });
    });
  }

  @override
  void dispose() {
    // channel.channel.sink.close();
    messageEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    UserModel user = arguments['user'];
    final int receiverId = user.id;
    // final chatVm = ref.watch(chatVmProvider(senderId).notifier);
    final chatState = ref.watch(chatVmProvider(receiverId));
    ref.listen(chatVmProvider(receiverId), (_, state) {
      switch (state) {
        // ignore: constant_pattern_never_matches_value_type
        case ChatStateStatus.initial:
          break;
        // ignore: constant_pattern_never_matches_value_type
        case ChatStateStatus.sending:
          Messages.showError('Mensagem enviado', context);
        // ignore: constant_pattern_never_matches_value_type
        case ChatStateStatus.error:
          Messages.showError("Erro ao enivar mennsagem", context);
        // ignore: constant_pattern_never_matches_value_type
        case ChatStateStatus.loaded:
          break;
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
          user.name,
          overflow: TextOverflow.visible,
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 14,
          ),
          chatState.when(
            data: (ChatState data) {
              // final socket = ref.watch(socketProvider);
              // socket.listenMessageReceiver(
              //   (msg) {},
              // );
              final sortMessages =
                  (List.of(data.messages)..sort((a, b) => a.createdAt.compareTo(b.createdAt)))
                    ..addAll(messages);

              return Expanded(
                child: ListView.builder(
                  itemCount: sortMessages.length,
                  itemBuilder: (context, index) {
                    final message = data.messages[index];
                    return Align(
                      alignment: user.id == message.senderId
                          ? Alignment.centerLeft
                          : Alignment.centerRight,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        decoration: BoxDecoration(
                          color: user.id == message.senderId
                              ? Colors.blue
                              : Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(message.text,
                            style: TextStyle(
                                color: user.id == message.senderId
                                    ? Colors.white
                                    : Colors.black)),
                      ),
                    );
                  },
                ),
              );
            },
            loading: () => const CircularProgressIndicator(),
            error: (error, stack) {
              log('Error: ', error: error, stackTrace: stack);
              return Text(
                'Erro: $error, $stack',
                overflow: TextOverflow.visible,
              );
            },
          ),
          MessageTextField(
            messageEC: messageEC,
            onPressed: () {
              final msg = {
                'receiverId': receiverId,
                'text': messageEC.text,
              };
              final socket = ref.watch(socketProvider);
              final result = socket.sendMessage(msg);
              switch (result) {
                case false:
                  Messages.showError('Mensagem não enviada', context);
                case true:
                  messageEC.clear();
              }
            },
          ),
        ],
      ),
    );
  }
}
