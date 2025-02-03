import 'package:flutter/material.dart';
import 'package:reborn/core/detalhes_telas/size_tela/size.dart';
import 'package:reborn/core/detalhes_telas/text/text_estilo.dart';

class TextFieldUsuario extends StatefulWidget {
  final TextEditingController textUsuario;
  const TextFieldUsuario({super.key, required this.textUsuario});

  @override
  State<TextFieldUsuario> createState() => _TextFieldUsuario();
}

class _TextFieldUsuario extends State<TextFieldUsuario> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      // margin: const EdgeInsets.only(bottom: 170),
      child: SizedBox(
        height: 60,
        width: context.screenMetadeLargura(0.5),
        child: TextField(
          controller: widget.textUsuario,
          decoration: InputDecoration(
            labelText: 'Usuário',
            labelStyle: context.textEstilo.textSemiBold.copyWith(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
          style: context.textEstilo.textRegular.copyWith(
            fontSize: 18,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
