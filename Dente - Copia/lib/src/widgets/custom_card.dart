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
  final Function()? onPressedCancelado;
  final Function()? onPressedConfirmado;
  final Function()? onPressedHisotorico;
  final Function()? onPressedHisotoricoPaciente;
  final bool? isAction;

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
    this.onPressedCancelado,
    this.onPressedConfirmado,
    this.onPressedHisotorico,
    this.onPressedHisotoricoPaciente,
    this.isAction,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
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
            Row(
              children: [
                Visibility(
                  visible: status == 'Pendente',
                  child: IconButton(
                    tooltip: 'Confirmar consulta',
                    padding: EdgeInsets.zero, // remove o padding padrão
                    constraints: BoxConstraints(),
                    onPressed: onPressedConfirmado,
                    style: ButtonStyle(
                      overlayColor: WidgetStateProperty.resolveWith<Color?>((
                        Set<WidgetState> states,
                      ) {
                        if (states.contains(WidgetState.hovered)) {
                          return Colors.green.withOpacity(0.3); // cor de hover
                        }
                        return null; // cor padrão
                      }),
                    ),
                    icon: Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 25,
                    ),
                  ),
                ),
                const SizedBox(width: 25),
                Visibility(
                  visible: status == 'Pendente',
                  child: IconButton(
                    tooltip: 'Cancelar agendamento',
                    padding: EdgeInsets.zero, // remove o padding padrão
                    constraints: BoxConstraints(),
                    onPressed: onPressedCancelado,
                    style: ButtonStyle(
                      overlayColor: WidgetStateProperty.resolveWith<Color?>((
                        Set<WidgetState> states,
                      ) {
                        if (states.contains(WidgetState.hovered)) {
                          return ColorsConstants.errorColor.withOpacity(
                            0.3,
                          ); // cor de hover
                        }
                        return null; // cor padrão
                      }),
                    ),
                    icon: Icon(
                      Icons.cancel,
                      color: ColorsConstants.errorColor,
                      size: 25,
                    ),
                  ),
                ),
                const SizedBox(width: 25),
                IconButton(
                  tooltip: 'Historico de consultas',
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
                    Icons.list_alt_outlined,
                    color: ColorsConstants.appBarColor,
                    size: 25,
                  ),
                ),
                const SizedBox(width: 25),
                IconButton(
                  tooltip: 'Historico do paciente',
                  padding: EdgeInsets.zero, // remove o padding padrão
                  constraints: BoxConstraints(),
                  onPressed: onPressedHisotorico,
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
          ],
        ),
      ),
    );
  }
}


// TextButton(
              //   onPressed: onPressed,

              //   style: ButtonStyle(
              //     overlayColor: WidgetStateProperty.resolveWith<Color?>((
              //       Set<WidgetState> states,
              //     ) {
              //       if (states.contains(WidgetState.hovered)) {
              //         return ColorsConstants.appBarColor.withOpacity(
              //           0.3,
              //         ); // cor de hover
              //       }
              //       return null; // cor padrão
              //     }),
              //     shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              //       RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(18.0),
              //         side: BorderSide(
              //           color: status == 'Pendente'
              //               ? ColorsConstants.buttonColor
              //               : status == 'Confirmado'
              //               ? Colors.green
              //               : status == 'Cancelado'
              //               ? ColorsConstants.errorColor
              //               : ColorsConstants.focusColor,
              //         ),
              //       ),
              //     ),
              //   ),
              //   child: Text(
              //     status ?? "",
              //     style: context.cusotomFontes.textBoldItalic.copyWith(
              //       color: status == 'Pendente'
              //           ? ColorsConstants.buttonColor
              //           : status == 'Confirmado'
              //           ? Colors.green
              //           : status == 'Cancelado'
              //           ? ColorsConstants.errorColor
              //           : ColorsConstants.focusColor,
              //       fontSize: 14,
              //     ),
              //   ),
              // ),