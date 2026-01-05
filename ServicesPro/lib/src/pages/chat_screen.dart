import 'package:flutter/material.dart';
import 'package:servicespro/core/ui/style/custom_colors.dart';
import 'package:servicespro/core/ui/style/fontes_letras.dart';
import 'package:servicespro/core/ui/widgets/tema_sistema.dart';
import 'package:servicespro/src/widgets/chat/bolia_messagem.dart';
import 'package:servicespro/src/widgets/custom_text_field.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsConstants.azulColor,
        title: Text(
          'Conversar com: Cliente/Prestador',
          style: context.cusotomFontes.bold.copyWith(
            color: ColorsConstants.primaryColor,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back, color: ColorsConstants.primaryColor),
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
