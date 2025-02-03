import 'package:activovo/src/ui/colors/colors_constants.dart';
import 'package:flutter/material.dart';

class FocoNewTreino extends StatelessWidget {
  final ValueChanged<String> onPressed;
  const FocoNewTreino({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 24,
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Escolha o foco do novo plano.',
              style: context.fontes.textExtraBold.copyWith(
                fontSize: 18,
                color: ColorsConstants.greyTitulos,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        //quebra a linha automaticamente
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            spacing: 8,
            runSpacing: 16,
            children: [
              FocosButton(
                onPressed: onPressed,
                label: 'Força Muscular',
              ),
              FocosButton(
                onPressed: onPressed,
                label: 'Equilíbrio e Coordenação',
              ),
              FocosButton(
                onPressed: onPressed,
                label: 'Flexibilidade',
              ),
              FocosButton(
                onPressed: onPressed,
                label: 'Resistência',
              ),
              FocosButton(
                onPressed: onPressed,
                label: 'Funcionalidade',
              ),
              FocosButton(
                onPressed: onPressed,
                label: 'Mobilidade ',
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            'O plano esta sujeito a modificações no preço e nos exercícios. Tem uma validade de 3 (três) meses.',
            style: context.fontes.textMedium.copyWith(
              fontSize: 14,
              color: ColorsConstants.greyTitulos,
            ),
          ),
        ),
        const SizedBox(
          height: 140,
        ),
      ],
    );
  }
}

class FocosButton extends StatefulWidget {
  final String label;

  final ValueChanged<String> onPressed;
  const FocosButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  State<FocosButton> createState() => _FocosButtonState();
}

class _FocosButtonState extends State<FocosButton> {
  var selected = false;
  @override
  Widget build(BuildContext context) {
    final textColor =
        selected ? ColorsConstants.greyEntryF : ColorsConstants.greyBotoes;
    var buttonColor =
        selected ? ColorsConstants.greyAppBar : ColorsConstants.greyEntryF;
    final buttonBorderColor =
        selected ? ColorsConstants.greyAppBar : ColorsConstants.greyEntryF;
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () {
        setState(() {
          selected = !selected;
          widget.onPressed(widget.label);
        });
      },
      child: Container(
        width: 105,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: buttonColor,
          border: Border.all(
            color: buttonBorderColor,
          ),
        ),
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            widget.label,
            style: TextStyle(
              fontSize: 12,
              color: textColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        )),
      ),
    );
  }
}
