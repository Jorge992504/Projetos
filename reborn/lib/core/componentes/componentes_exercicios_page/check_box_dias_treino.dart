import 'package:flutter/material.dart';
import 'package:reborn/core/detalhes_telas/text/text_estilo.dart';
import 'package:reborn/core/modelos/modelo_dias_treino.dart';

class CheckBoxDiasTreino extends StatefulWidget {
  final bool isCheck;
  final ModeloDiasTreino dias;
  final Function salvarDias;

  const CheckBoxDiasTreino({
    super.key,
    required this.dias,
    required this.salvarDias,
    required this.isCheck,
  });

  @override
  State<CheckBoxDiasTreino> createState() => _CheckBoxDiasTreino();
}

class _CheckBoxDiasTreino extends State<CheckBoxDiasTreino> {
  bool isCheck = false;
  bool isEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Checkbox(
          value: isCheck,
          onChanged: (value) => setState(() {
            //controlar o estado dentro do salvar
            widget.salvarDias(widget.dias);
            isCheck = value!;
            if (isCheck) {}
          }),
        ),
        Expanded(
          child: Text(
            widget.dias.nome,
            style: context.textEstilo.textMedium.copyWith(
              fontSize: 14,
              color: Colors.black,
            ),
            softWrap: true,
            overflow: TextOverflow.visible,
          ),
        ),
      ],
    );
  }
}
