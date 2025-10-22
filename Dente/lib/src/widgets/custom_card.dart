import 'package:dente/core/ui/style/custom_colors.dart';
import 'package:dente/core/ui/style/fontes_letras.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BoxDecoration? decoration;
  final AlignmentGeometry? alignment;
  final String? nome;
  final String? servico;
  final String? horario;
  final String? status;
  final Function()? onPressed;

  const CustomCard({
    super.key,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.decoration,
    this.alignment,
    this.nome,
    this.servico,
    this.horario,
    this.status,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: decoration,
      alignment: alignment,
      child: Card(
        elevation: 8,
        color: ColorsConstants.primaryColor,
        shadowColor: ColorsConstants.appBarColor,

        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                nome ?? "",
                style: context.cusotomFontes.textBoldItalic.copyWith(
                  color: ColorsConstants.letrasColor,
                  fontSize: 14,
                ),
              ),
              Text(
                servico ?? "",
                style: context.cusotomFontes.textBoldItalic.copyWith(
                  color: ColorsConstants.letrasColor,
                  fontSize: 14,
                ),
              ),
              Text(
                horario ?? "",
                style: context.cusotomFontes.textBoldItalic.copyWith(
                  color: ColorsConstants.letrasColor,
                  fontSize: 14,
                ),
              ),
              TextButton(
                onPressed: onPressed,

                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(
                        color: status == 'Pendente'
                            ? ColorsConstants.buttonColor
                            : status == 'Confirmado'
                            ? Colors.green
                            : status == 'Cancelado'
                            ? ColorsConstants.errorColor
                            : ColorsConstants.focusColor,
                      ),
                    ),
                  ),
                ),
                child: Text(
                  status ?? "",
                  style: context.cusotomFontes.textBoldItalic.copyWith(
                    color: status == 'Pendente'
                        ? ColorsConstants.buttonColor
                        : status == 'Confirmado'
                        ? Colors.green
                        : status == 'Cancelado'
                        ? ColorsConstants.errorColor
                        : ColorsConstants.focusColor,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
