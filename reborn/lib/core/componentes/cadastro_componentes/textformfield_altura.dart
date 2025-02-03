import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reborn/core/detalhes_telas/text/text_estilo.dart';
import 'package:reborn/core/pages/cadastro/cadastro_page.dart';
import 'package:validatorless/validatorless.dart';

class TextFormFielAltura extends StatefulWidget {
  final TextEditingController textAltura;
  const TextFormFielAltura({super.key, required this.textAltura});

  @override
  State<TextFormFielAltura> createState() => _TextFormFielAltura();
}

class _TextFormFielAltura extends State<TextFormFielAltura> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 250,
      child: TextFormField(
        controller: textAltura,
        validator: Validatorless.required('Altura obrigatoria'),
        style: context.textEstilo.textSemiBold.copyWith(
          fontSize: 16,
          color: Colors.black,
        ),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^\d+\,?\d{0,2}')),
        ],
        decoration: InputDecoration(
          labelText: 'Altura em cm',
          labelStyle: context.textEstilo.textMedium.copyWith(
            fontSize: 14,
            color: Colors.black,
          ),
          suffixIcon: const Icon(
            Icons.height,
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
