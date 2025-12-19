import 'package:flutter/material.dart';
import 'package:servicespro/src/widgets/chat/bolia_messagem.dart';
import 'package:servicespro/src/widgets/custom_text_field.dart';

class SuporteScreen extends StatefulWidget {
  const SuporteScreen({super.key});

  @override
  State<SuporteScreen> createState() => _SuporteScreenState();
}

class _SuporteScreenState extends State<SuporteScreen> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(title: const Text('Ajuda e Suporte')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: BoliaMessagem(
                isMe: true,
                text:
                    'Enviar mensagem para a equipe de suporte. Você recebera um email com a resposta da sua duvida ou solução de seu problema.',
              ),
            ),
            const SizedBox(height: 24),
            CustomTextField(
              isDark: isDark,
              label:
                  "Enviar mensagem para a equipe de suporte. Você recebera um email com a resposta da sua duvida ou solução de seu problema.",
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
      ),
    );
  }
}
