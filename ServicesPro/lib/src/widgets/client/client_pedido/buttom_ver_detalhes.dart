import 'package:flutter/material.dart';
import 'package:servicespro/core/ui/style/custom_colors.dart';
import 'package:servicespro/core/ui/style/fontes_letras.dart';
import 'package:servicespro/core/ui/style/size_extension.dart';

class ButtomVerDetalhes extends StatelessWidget {
  final void Function()? onPressedVerDetalhes;
  const ButtomVerDetalhes({super.key, this.onPressedVerDetalhes});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressedVerDetalhes,

      child: Container(
        width: context.percentWidth(0.4),
        height: 25,

        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: ColorsConstants.azulColor,
        ),

        child: Text(
          "Ver Detalhes",
          style: context.cusotomFontes.bold.copyWith(
            color: ColorsConstants.primaryColor,
          ),
        ),
      ),
    );
  }
}
