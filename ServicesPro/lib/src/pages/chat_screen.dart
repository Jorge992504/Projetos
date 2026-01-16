import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:servicespro/core/ui/style/custom_colors.dart';
import 'package:servicespro/core/ui/style/fontes_letras.dart';
import 'package:servicespro/core/ui/widgets/tema_sistema.dart';
import 'package:servicespro/src/providers/web_socket_provider.dart';
import 'package:servicespro/src/widgets/chat/bolia_messagem.dart';
import 'package:servicespro/src/widgets/custom_text_field.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  int usuarioId = 0;
  String usuarioNome = '';
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
      Provider.of<WebSocketProvider>(context, listen: false).conectar();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TemaSistema().temaSistema(context)
            ? ColorsConstants.letrasColor
            : ColorsConstants.primaryColor,
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            Provider.of<WebSocketProvider>(context, listen: false).conetado
                ? '$usuarioNome - *'
                : usuarioNome,
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: BoliaMessagem(
              isMe: true,
              text: 'Mensage enviada pelo usuario',
            ),
          ),
          const SizedBox(height: 24),
          CustomTextField(
            isDark: TemaSistema().temaSistema(context),
            label: "Enviar mensagem para: Cliente/Prestador de serviço",
            noLabel: true,
            textAlign: TextAlign.left,
            maxLines: 4,
            height: 100,
            suffixIcon: IconButton(
              onPressed: () {},
              icon: Icon(Icons.send_rounded),
            ),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
