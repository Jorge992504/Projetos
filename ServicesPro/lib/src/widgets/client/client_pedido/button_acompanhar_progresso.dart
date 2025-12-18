import 'package:flutter/material.dart';
import 'package:servicespro/core/ui/style/custom_colors.dart';
import 'package:servicespro/core/ui/style/fontes_letras.dart';
import 'package:servicespro/core/ui/style/size_extension.dart';

class ButtonAcompanharProgresso extends StatelessWidget {
  final void Function()? onPressedAcompanharProgresso;

  const ButtonAcompanharProgresso({
    super.key,
    this.onPressedAcompanharProgresso,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressedAcompanharProgresso,

      child: Container(
        width: context.percentWidth(0.55),
        height: 25,

        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: ColorsConstants.azulColor,
        ),

        child: Text(
          "Acompanhar Progresso",
          style: context.cusotomFontes.bold.copyWith(
            color: ColorsConstants.primaryColor,
          ),
        ),
      ),
    );
  }
}
