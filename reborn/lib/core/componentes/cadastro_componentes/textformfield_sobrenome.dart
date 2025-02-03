import 'package:flutter/material.dart';
import 'package:reborn/core/detalhes_telas/text/text_estilo.dart';
import 'package:reborn/core/pages/cadastro/cadastro_page.dart';
import 'package:validatorless/validatorless.dart';

class TextFormFielSobreNome extends StatefulWidget {
  final TextEditingController textSobreNome;
  const TextFormFielSobreNome({super.key, required this.textSobreNome});

  @override
  State<TextFormFielSobreNome> createState() => _TextFormFielSobreNome();
}

class _TextFormFielSobreNome extends State<TextFormFielSobreNome> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 250,
      child: TextFormField(
        controller: textSobreNome,
        validator: Validatorless.required('Sobrenome obrigatorio'),
        style: context.textEstilo.textSemiBold.copyWith(
          fontSize: 16,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          labelText: 'Sobrenome',
          labelStyle: context.textEstilo.textMedium.copyWith(
            fontSize: 14,
            color: Colors.black,
          ),
          suffixIcon: const Icon(
            Icons.person_outline,
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
