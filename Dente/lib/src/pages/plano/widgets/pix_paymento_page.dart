import 'dart:convert';
import 'package:dente/core/ui/style/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PixPaymentoPage extends StatelessWidget {
  final String qrCodeBase64;
  final String copiaCola;
  const PixPaymentoPage({
    super.key,
    required this.qrCodeBase64,
    required this.copiaCola,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(padding: const EdgeInsets.only(top: 8)),
        // QR CODE
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: ColorsConstants.primaryColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: ColorsConstants.appBarColor,
                blurRadius: 8,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Image.memory(
            base64Decode(qrCodeBase64),
            width: 220,
            height: 220,
            fit: BoxFit.cover,
            color: ColorsConstants.primaryColor,
            colorBlendMode: BlendMode.modulate,
          ),
        ),

        Padding(padding: const EdgeInsets.only(top: 8)),

        // TÍTULO
        const Text(
          "Código Pix (Copia e Cola)",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),

        Padding(padding: const EdgeInsets.only(top: 8)),

        // CAMPO DO CÓDIGO
        Container(
          width: 500,
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: ColorsConstants.primaryColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: ColorsConstants.appBarColor,
                blurRadius: 8,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: SelectableText(
            copiaCola,
            style: const TextStyle(fontSize: 14),
          ),
        ),

        Padding(padding: const EdgeInsets.only(top: 30)),

        // BOTÃO COPIAR
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorsConstants.buttonColor,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: () {
            Clipboard.setData(ClipboardData(text: copiaCola));
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  "Código Pix copiado!",
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.green,
              ),
            );
          },
          icon: Icon(Icons.copy, color: ColorsConstants.primaryColor),
          label: Text(
            "Copiar código",
            style: TextStyle(color: ColorsConstants.primaryColor),
          ),
        ),
        Padding(padding: const EdgeInsets.only(top: 8)),
      ],
    );
  }
}
