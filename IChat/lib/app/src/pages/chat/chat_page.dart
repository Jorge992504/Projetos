import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ichat/app/core/ui/base/base_state.dart';
import 'package:ichat/app/src/models/messages_model.dart';
import 'package:ichat/app/src/models/path_message_model_request.dart';
import 'package:ichat/app/src/pages/chat/chat_controller.dart';
import 'package:ichat/app/src/pages/chat/chat_state.dart';
import 'package:ichat/app/src/providers/web_socket_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends BaseState<ChatPage, ChatController> {
  String userFrom = '';
  final TextEditingController _controllerMensagem = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool isImage = false;
  final ImagePicker _picker = ImagePicker();
  XFile? image = XFile("s");

  @override
  void onReady() {
    super.onReady();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final route = ModalRoute.of(context);
      final arguments =
          (route!.settings.arguments ?? <String, dynamic>{}) as Map;
      userFrom = arguments['userFrom'];

      // Busca mensagens iniciais do banco via BLoC
      controller.buscaMessages(userFrom);
    });
    _scrollParaUltimaMensagem();
  }

  /// Rola para a última mensagem
  void _scrollParaUltimaMensagem() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final wsProvider = Provider.of<WebSocketProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text(userFrom)),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<ChatController, ChatState>(
              listener: (context, state) {
                state.status.matchAny(
                  any: hideLoader,
                  loading: showLoader,
                  loaded: () {
                    hideLoader();
                    // NÃO adicionar mensagens do BLoC no WebSocket
                    _scrollParaUltimaMensagem();
                  },
                  error: () {
                    showError(
                      state.errorMessage ?? 'Erro ao carregar mensagens',
                    );
                    hideLoader();
                  },
                  send: () {
                    hideLoader();
                    // NÃO adicionar mensagens do BLoC no WebSocket
                    _scrollParaUltimaMensagem();
                  },
                );
              },
              builder: (context, state) {
                return Consumer<WebSocketProvider>(
                  builder: (context, wsProvider, _) {
                    //filtra as mensgaens do chat
                    final mensagensFiltradas = wsProvider.messagens
                        .where(
                          (m) =>
                              (m.userFrom == userFrom &&
                                  m.userTo == wsProvider.usuarioLogado) ||
                              (m.userFrom == wsProvider.usuarioLogado &&
                                  m.userTo == userFrom),
                        )
                        .toList();

                    // Mescla mensagens do BLoC + WebSocket e ordena
                    final todasMensagens = [
                      ...?state.messages,
                      ...mensagensFiltradas,
                    ];

                    //adiciona um filtro para remover mensagens com sentAt nulo
                    todasMensagens.removeWhere((m) => m.sentAt == null);
                    todasMensagens.sort(
                      (a, b) => a.sentAt!.compareTo(b.sentAt!),
                    );

                    return ListView.builder(
                      // controller: _scrollController,
                      padding: const EdgeInsets.all(16),
                      itemCount: todasMensagens.length,
                      itemBuilder: (context, index) {
                        final msg = todasMensagens[index];
                        final isMe = msg.userTo != wsProvider.usuarioLogado;

                        return Align(
                          alignment: isMe
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 16,
                            ),
                            margin: const EdgeInsets.only(bottom: 8),
                            decoration: BoxDecoration(
                              color: isMe
                                  ? Colors.blue
                                  : Colors.greenAccent.shade100,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: msg.isPick == true
                                ? _buildImageMessage(msg.message!)
                                : Text(
                                    msg.message ?? "",
                                    style: TextStyle(
                                      color: isMe ? Colors.white : Colors.black,
                                    ),
                                  ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
          // Campo de envio
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.camera_alt),
                  onPressed: () async {
                    final foto = await abrirCamera();
                    if (foto != null) {
                      setState(() {
                        isImage = !isImage;
                      });
                      image = foto;
                    }
                  },
                ),
                IconButton(
                  icon: Icon(Icons.photo_library),
                  onPressed: () async {
                    final foto = await abrirGaleria();
                    if (foto != null) {
                      setState(() {
                        isImage = !isImage;
                      });
                      image = foto;
                    }
                  },
                ),
                Expanded(
                  child: TextField(
                    controller: _controllerMensagem,
                    decoration: InputDecoration(
                      hintText: 'Digite sua mensagem...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () async {
                    if (!isImage) {
                      await controller.salvaMessages(
                        MessagesModel(
                          userFrom: userFrom,
                          userTo: wsProvider.usuarioLogado,
                          message: _controllerMensagem.text,
                          isPick: isImage,
                        ),
                      );

                      final response = await wsProvider.enviarMessagens(
                        userFrom,
                        _controllerMensagem.text,
                      );
                      if (response) {
                        _controllerMensagem.clear();
                        _scrollParaUltimaMensagem();
                      }
                    } else {
                      PathMessageModelRequest? send = await controller
                          .salvaMessages(
                            MessagesModel(
                              userFrom: userFrom,
                              userTo: wsProvider.usuarioLogado,
                              image: image,
                              isPick: isImage,
                            ),
                          );
                      if (send!.path != null) {
                        final response = await wsProvider.enviarMessagens(
                          userFrom,
                          send.path ?? "",
                        );
                        if (response) {
                          _controllerMensagem.clear();
                          _scrollParaUltimaMensagem();
                        }
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //abrir camera
  Future<XFile?> abrirCamera() async {
    final XFile? foto = await _picker.pickImage(source: ImageSource.camera);
    return foto;
  }

  //abrir galeria
  Future<XFile?> abrirGaleria({bool video = false}) async {
    if (video) {
      return await _picker.pickVideo(source: ImageSource.gallery);
    } else {
      return await _picker.pickImage(source: ImageSource.gallery);
    }
  }

  /// Mostra imagem a partir do base64
  Widget _buildImageMessage(String base64String) {
    try {
      Uint8List imageBytes = base64Decode(base64String);
      return Image.memory(
        imageBytes,
        width: 150,
        height: 150,
        fit: BoxFit.cover,
      );
    } catch (e) {
      return const Text("Erro ao carregar imagem");
    }
  }
}
