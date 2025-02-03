import 'package:flutter/material.dart';
import 'package:reborn/core/detalhes_telas/text/text_estilo.dart';
//import 'package:reborn/core/detalhes_telas/text/text_estilo.dart';
//import 'package:reborn/core/detalhes_telas/size_tela/size.dart';

class BotonEntrar extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;

  const BotonEntrar({super.key, required this.label, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      margin: const EdgeInsets.only(bottom: 80),
      child: SizedBox(
        width: 150,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
            textStyle: MaterialStateProperty.all<TextStyle>(
                context.textEstilo.textRegular),
          ),
          onPressed: onPressed,
          child: Text(label),
        ),
      ),
    );
  }
}
