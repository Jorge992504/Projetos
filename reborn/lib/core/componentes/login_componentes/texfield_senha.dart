import 'package:flutter/material.dart';

import 'package:reborn/core/detalhes_telas/size_tela/size.dart';
import 'package:reborn/core/detalhes_telas/text/text_estilo.dart';
//import 'package:validatorless/validatorless.dart';

class TextFieldSenha extends StatefulWidget {
  final TextEditingController textSenha;
  const TextFieldSenha({super.key, required this.textSenha});

  @override
  State<TextFieldSenha> createState() => _TextFieldSenha();
}

class _TextFieldSenha extends State<TextFieldSenha> {
  bool _senhaFalse = true;

//---------------------------Habilitar-senha------------------------------------
  void habilitarSenha() {
    setState(() {
      _senhaFalse = !_senhaFalse;
    });
  }

//------------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      // margin: const EdgeInsets.only(bottom: 130),
      child: SizedBox(
        height: 60,
        width: context.screenMetadeLargura(0.5),
        child: TextField(
          controller: widget.textSenha,
          decoration: InputDecoration(
            labelText: 'Senha',
            labelStyle: context.textEstilo.textSemiBold
                .copyWith(fontSize: 14, color: Colors.black),
            // border: const OutlineInputBorder(),
            suffixIcon: IconButton(
              icon: Icon(
                _senhaFalse ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () {
                habilitarSenha();
              },
            ),
          ),
          style: context.textEstilo.textRegular
              .copyWith(fontSize: 18, color: Colors.black),
          obscureText: _senhaFalse,
        ),
      ),
    );
  }
}
