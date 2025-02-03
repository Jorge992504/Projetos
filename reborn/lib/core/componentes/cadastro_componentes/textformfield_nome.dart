import 'package:flutter/material.dart';
import 'package:reborn/core/detalhes_telas/text/text_estilo.dart';
import 'package:reborn/core/pages/cadastro/cadastro_page.dart';
import 'package:validatorless/validatorless.dart';

class TextFormFielNome extends StatefulWidget {
  final TextEditingController textNome;
  const TextFormFielNome({super.key, required this.textNome});

  @override
  State<TextFormFielNome> createState() => _TextFormFielNome();
}

class _TextFormFielNome extends State<TextFormFielNome> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 250,
      child: TextFormField(
        controller: textNome,
        validator: Validatorless.required('Nome obrigatorio'),
        style: context.textEstilo.textSemiBold.copyWith(
          fontSize: 16,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          labelText: 'Nome',
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
