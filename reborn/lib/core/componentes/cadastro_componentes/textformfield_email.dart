import 'package:flutter/material.dart';
import 'package:reborn/core/detalhes_telas/text/text_estilo.dart';
import 'package:reborn/core/pages/cadastro/cadastro_page.dart';
import 'package:validatorless/validatorless.dart';

class TextFormFielEmail extends StatefulWidget {
  final TextEditingController textEmail;
  const TextFormFielEmail({super.key, required this.textEmail});

  @override
  State<TextFormFielEmail> createState() => _TextFormFielEmail();
}

class _TextFormFielEmail extends State<TextFormFielEmail> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 250,
      child: TextFormField(
        controller: textEmail,
        validator: Validatorless.multiple(
          [
            Validatorless.required('Email obrigatorio'),
            Validatorless.email('Email obrigatorio'),
          ],
        ),
        style: context.textEstilo.textSemiBold.copyWith(
          fontSize: 16,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          labelText: 'Email',
          labelStyle: context.textEstilo.textMedium.copyWith(
            fontSize: 14,
            color: Colors.black,
          ),
          suffixIcon: const Icon(
            Icons.email,
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
