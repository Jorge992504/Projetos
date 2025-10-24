import 'package:dente/core/ui/style/custom_colors.dart';
import 'package:dente/core/ui/style/fontes_letras.dart';
import 'package:flutter/material.dart';

class CardHistoricoConsultas extends StatelessWidget {
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
  final Function()? onPressedHisotoricoPaciente;
  final bool? isAction;

  const CardHistoricoConsultas({
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
    this.onPressedHisotoricoPaciente,
    this.isAction,
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

              Container(
                alignment: Alignment.center,
                width: 80,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: status == 'Pendente'
                        ? ColorsConstants.buttonColor
                        : status == 'Realizado'
                        ? Colors.green
                        : status == 'Cancelado'
                        ? ColorsConstants.errorColor
                        : ColorsConstants.focusColor,
                  ),
                  borderRadius: BorderRadius.circular(18.0),
                ),
                child: Text(
                  status ?? "",
                  style: context.cusotomFontes.textBoldItalic.copyWith(
                    color: status == 'Pendente'
                        ? ColorsConstants.buttonColor
                        : status == 'Realizado'
                        ? Colors.green
                        : status == 'Cancelado'
                        ? ColorsConstants.errorColor
                        : ColorsConstants.focusColor,
                    fontSize: 14,
                  ),
                ),
              ),
              IconButton(
                tooltip: 'Historico do paciente',
                padding: EdgeInsets.zero, // remove o padding padrão
                constraints: BoxConstraints(),
                onPressed: onPressedHisotoricoPaciente,
                style: ButtonStyle(
                  overlayColor: WidgetStateProperty.resolveWith<Color?>((
                    Set<WidgetState> states,
                  ) {
                    if (states.contains(WidgetState.hovered)) {
                      return ColorsConstants.appBarColor.withOpacity(
                        0.3,
                      ); // cor de hover
                    }
                    return null; // cor padrão
                  }),
                ),
                icon: Icon(
                  Icons.filter_list_sharp,
                  color: ColorsConstants.appBarColor,
                  size: 25,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
