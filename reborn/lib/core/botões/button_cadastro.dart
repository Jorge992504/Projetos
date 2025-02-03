import 'package:flutter/material.dart';
//import 'package:reborn/core/detalhes_telas/size_tela/size.dart';
import 'package:reborn/core/detalhes_telas/text/text_estilo.dart';

class BotonCadastrar extends StatelessWidget {
  final String label;
  final String label1;
  final VoidCallback? onPressed;

  const BotonCadastrar(
      {super.key, required this.label, this.onPressed, required this.label1});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label,
          style: context.textEstilo.textSemiBold
              .copyWith(fontSize: 13, color: Colors.black),
        ),
        TextButton(
          onPressed: onPressed,
          child: Text(
            label1,
            style: context.textEstilo.textSemiBold
                .copyWith(fontSize: 13, color: Colors.blue),
          ),
        ),
      ],
    );
  }
}
