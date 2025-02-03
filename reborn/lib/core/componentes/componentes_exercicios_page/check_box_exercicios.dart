import 'package:flutter/material.dart';
import 'package:reborn/core/detalhes_telas/text/text_estilo.dart';
import 'package:reborn/core/modelos/modelo_doenca.dart';
// import 'package:reborn/core/modelos/modelo_exercicios.dart';

class CheckBoxExercicios extends StatefulWidget {
  final bool isCheck;
  final ModeloDoenca doenca;
  final Function salvarExercicio;

  const CheckBoxExercicios({
    super.key,
    required this.doenca,
    required this.salvarExercicio,
    required this.isCheck,
  });

  @override
  State<CheckBoxExercicios> createState() => _CheckBoxExercicios();
}

class _CheckBoxExercicios extends State<CheckBoxExercicios> {
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
            widget.salvarExercicio(widget.doenca);
            isCheck = value!;
            if (isCheck) {}
          }),
        ),
        Expanded(
          child: Text(
            widget.doenca.nome,
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
