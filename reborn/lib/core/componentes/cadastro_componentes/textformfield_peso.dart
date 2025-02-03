import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reborn/core/detalhes_telas/text/text_estilo.dart';
import 'package:reborn/core/pages/cadastro/cadastro_page.dart';
import 'package:validatorless/validatorless.dart';

class TextFormFielPeso extends StatefulWidget {
  final TextEditingController textPeso;
  const TextFormFielPeso({super.key, required this.textPeso});

  @override
  State<TextFormFielPeso> createState() => _TextFormFielPeso();
}

class _TextFormFielPeso extends State<TextFormFielPeso> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 250,
      child: TextFormField(
        controller: textPeso,
        validator: Validatorless.required('Peso obrigatorio'),
        style: context.textEstilo.textSemiBold.copyWith(
          fontSize: 16,
          color: Colors.black,
        ),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^\d+\,?\d{0,2}')),
        ],
        decoration: InputDecoration(
          labelText: 'Peso em kg',
          labelStyle: context.textEstilo.textMedium.copyWith(
            fontSize: 14,
            color: Colors.black,
          ),
          suffixIcon: const Icon(
            Icons.fitness_center,
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
