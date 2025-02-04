import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:homechat/src/core/fp/either.dart';
import 'package:homechat/src/core/keys/local_storage_keys.dart';
import 'package:homechat/src/core/models/user_model.dart';
import 'package:homechat/src/pages/chat/chat_state.dart';
import 'package:homechat/src/pages/chat/chat_vm.dart';
import 'package:homechat/src/pages/chat/widgets/message_text_field.dart';
import 'package:homechat/src/ui/helpers/messages.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatPage extends ConsumerStatefulWidget {
  const ChatPage({super.key});

  @override
  ConsumerState<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  final channel = ChatVm();
  final messageEC = TextEditingController();

  @override
  void initState() {
    // channel.init();
    super.initState();
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
    final chatState = ref.watch(chatVmProvider(receiverId));
    final chatVm = ref.read(chatVmProvider(receiverId).notifier);

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
              final sortMessages = List.of(data.messages)
                ..sort((a, b) => a.createdAt.compareTo(b.createdAt));
              return Expanded(
                child: ListView.builder(
                  itemCount: sortMessages.length,
                  itemBuilder: (context, index) {
                    final message = data.messages[index];
                    final isMe = message.senderId;
                    return Align(
                      alignment: user.id == isMe
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        decoration: BoxDecoration(
                          color:
                              user.id == isMe ? Colors.blue : Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(message.text,
                            style: TextStyle(
                                color: user.id == isMe
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
            onPressed: () async {
              final sp = await SharedPreferences.getInstance();
              final accessToken = sp.getString(LocalStorageKeys.token);
              Map<String, dynamic> payload = Jwt.parseJwt(accessToken!);
              int id = payload['id'];
              final result = chatVm.sendMessages(
                user.id,
                id,
                messageEC.text,
              );
              switch (result) {
                case Success():
                  messageEC.clear();
                case Failure():
                  Messages.showError('Mensagem não enviado', context);
              }
            },
          ),
        ],
      ),
    );
  }
}


// child: ValueListenableBuilder(
            //   valueListenable: channel.msg,
            //   builder: (context, messages, _) {
            //     return chatState.when(
            //       data: (ChatState messages) {
            //         return ListView.builder(
            //           itemCount: messages.messages.length,
            //           itemBuilder: (context, index) {
            //             final message = messages.messages[index];

            //             if (message.receiverId == user.id) {
            //               return MessageReceiver(message: message.text);
            //             }
            //             return MessageSender(
            //               message: message.text,
            //             );
            //           },
            //         );
            //       },
            //       error: (error, stackTrace) =>
            //           Center(child: Text('Erro: $error')),
            //       loading: () =>
            //           const Center(child: CircularProgressIndicator()),
            //     );
            //   },
            // ),



          //   Expanded(
            
          //   child: ListView.builder(
          //     itemCount: ,
          //     itemBuilder: (context, index) {
          //       final message = chatState.messages[index];
          //       final isMe = message.isMe;
          //       return Align(
          //         alignment:
          //             isMe ? Alignment.centerRight : Alignment.centerLeft,
          //         child: Container(
          //           padding: const EdgeInsets.all(10),
          //           margin:
          //               const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          //           decoration: BoxDecoration(
          //             color: isMe ? Colors.blue : Colors.grey[300],
          //             borderRadius: BorderRadius.circular(10),
          //           ),
          //           child: Text(message.text,
          //               style: TextStyle(
          //                   color: isMe ? Colors.white : Colors.black)),
          //         ),
          //       );
          //     },
          //   ),
          // ),