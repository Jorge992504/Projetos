import 'package:flutter/material.dart';
import 'package:reborn/core/detalhes_telas/text/text_estilo.dart';
import 'package:reborn/core/pages/cadastro/cadastro_page.dart';
import 'package:validatorless/validatorless.dart';

class TextFormFieldSenha extends StatefulWidget {
  final TextEditingController textSenha;
  const TextFormFieldSenha({super.key, required this.textSenha});

  @override
  State<TextFormFieldSenha> createState() => _TextFormFieldSenha();
}

class _TextFormFieldSenha extends State<TextFormFieldSenha> {
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
    return SizedBox(
      height: 50,
      width: 250,
      child: TextFormField(
        controller: textSenha,
        validator: Validatorless.required('Senha obrigatorio'),
        decoration: InputDecoration(
          labelText: 'Senha',
          labelStyle: context.textEstilo.textMedium.copyWith(
            fontSize: 14,
            color: Colors.black,
          ),
          // border: const OutlineInputBorder(),
          floatingLabelStyle: context.textEstilo.textLight.copyWith(
            fontSize: 8,
            color: Colors.transparent,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              color: Colors.black,
              _senhaFalse ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: () {
              habilitarSenha();
            },
          ),
        ),
        style: context.textEstilo.textSemiBold.copyWith(
          fontSize: 16,
          color: Colors.black,
        ),
        obscureText: _senhaFalse,
      ),
    );
  }
}
