import 'package:flutter/material.dart';
import 'package:reborn/core/detalhes_telas/text/text_estilo.dart';
import 'package:reborn/core/pages/cadastro/cadastro_page.dart';
import 'package:validatorless/validatorless.dart';

class TextFormFielUsuario extends StatefulWidget {
  final TextEditingController textUsuario;
  const TextFormFielUsuario({super.key, required this.textUsuario});

  @override
  State<TextFormFielUsuario> createState() => _TextFormFielUsuario();
}

class _TextFormFielUsuario extends State<TextFormFielUsuario> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 250,
      child: TextFormField(
        controller: textUsuario,
        validator: Validatorless.multiple(
          [
            Validatorless.required('Usuário obrigatorio'),
          ],
        ),
        style: context.textEstilo.textSemiBold.copyWith(
          fontSize: 16,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          labelText: 'Usuário',
          labelStyle: context.textEstilo.textMedium.copyWith(
            fontSize: 14,
            color: Colors.black,
          ),
          suffixIcon: const Icon(
            Icons.person,
            color: Colors.black,
          ),
          floatingLabelStyle: context.textEstilo.textLight.copyWith(
            fontSize: 8,
            color: Colors.transparent,
          ),
        ),
      ),
    );
  }
}
