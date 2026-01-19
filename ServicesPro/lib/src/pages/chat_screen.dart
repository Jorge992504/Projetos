import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:servicespro/core/ui/base/base_state.dart';
import 'package:servicespro/core/ui/style/custom_colors.dart';
import 'package:servicespro/core/ui/style/fontes_letras.dart';
import 'package:servicespro/core/ui/widgets/tema_sistema.dart';
import 'package:servicespro/src/controllers/chat_controller.dart';
import 'package:servicespro/src/models/message_model.dart';
import 'package:servicespro/src/providers/web_socket_provider.dart';
import 'package:servicespro/src/states/chat_state.dart';
import 'package:servicespro/src/widgets/chat/bolia_messagem.dart';
import 'package:servicespro/src/widgets/custom_text_field.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends BaseState<ChatScreen, ChatController> {
  int usuarioId = 0;
  String usuarioNome = '';
  List<MessageModel> messages = [];
  final messageController = TextEditingController();
  final messageFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final route = ModalRoute.of(context);
      final arguments =
          (route!.settings.arguments ?? <String, dynamic>{}) as Map;
      setState(() {
        usuarioId = arguments['usuarioId'];
        usuarioNome = arguments['usuarioNome'];
      });
      List<MessageModel> messagesBD = await controller.buscarMessages(
        usuarioId,
      );
      Provider.of<WebSocketProvider>(
        // ignore: use_build_context_synchronously
        context,
        listen: false,
      ).atualizarLista(messagesBD);
      // ignore: use_build_context_synchronously
      controller.atualizarMessages(context);
    });
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<WebSocketProvider>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TemaSistema().temaSistema(context)
            ? ColorsConstants.letrasColor
            : ColorsConstants.primaryColor,
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            usuarioNome,
            style: context.cusotomFontes.bold.copyWith(
              color: TemaSistema().temaSistema(context)
                  ? ColorsConstants.primaryColor
                  : ColorsConstants.letrasColor,
            ),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: TemaSistema().temaSistema(context)
                ? ColorsConstants.primaryColor
                : ColorsConstants.letrasColor,
          ),
        ),
      ),
      body: BlocConsumer<ChatController, ChatState>(
        listener: (context, state) async {
          switch (state) {
            case ChatInitial():
              showLoader();
              break;
            case ChatLoading():
              showLoader();
              break;
            case ChatLoaded():
              hideLoader();
              break;
            case ChatConnecting():
              showLoader();
              break;

            case ChatConnected():
              hideLoader();
              break;

            case ChatFailure(:final errorMessage):
              hideLoader();
              showError(
                errorMessage!.isNotEmpty
                    ? errorMessage
                    : 'Login ou senha inválidos',
              );
              break;

            case ChatReconnected():
              showLoader();
              break;

            case ChatDisconnected():
              showLoader();
              break;

            case ChatMessageReceived():
              hideLoader();
              setState(() {
                messages = state.messages;
              });

              break;
          }
        },
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    MessageModel message = messages[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: BoliaMessagem(
                        isMe: message.isMe ?? false,
                        text: message.message ?? "",
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
              CustomTextField(
                isDark: TemaSistema().temaSistema(context),
                label: "Enviar mensagem para: $usuarioNome",
                noLabel: true,
                textAlign: TextAlign.left,
                maxLines: 4,
                height: 100,
                controller: messageController,
                focusNode: messageFocus,
                suffixIcon: IconButton(
                  onPressed: () async {
                    if (messageController.text.isEmpty) {
                      messageFocus.requestFocus();
                      return;
                    }
                    MessageModel messageModel = MessageModel(
                      dataTime: DateTime.now(),
                      foto: "",
                      message: messageController.text,
                      usuarioTo: usuarioId,
                    );
                    final foto = await controller.salvarMessages(messageModel);
                    final response = await controller.enviarMensagem(
                      usuarioId,
                      messageController.text,
                      foto['foto'] ?? "",
                    );
                    if (response) {
                      messageController.clear();
                      // ignore: use_build_context_synchronously
                      controller.atualizarMessages(context);
                    }
                    // log('$messages');
                  },
                  icon: Icon(Icons.send_rounded),
                ),
              ),
              const SizedBox(height: 50),
            ],
          );
        },
      ),
    );
  }
}
