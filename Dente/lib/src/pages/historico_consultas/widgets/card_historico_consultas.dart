import 'package:dente/core/ui/style/custom_colors.dart';
import 'package:dente/core/ui/style/fontes_letras.dart';
import 'package:flutter/material.dart';

class CardHistoricoConsultas extends StatelessWidget {
  final String? nome;
  final String? servico;
  final String? horario;
  final String? status;
  final String? atedimento;
  final Function()? onPressedHisotoricoPaciente;
  final bool? isAction;

  const CardHistoricoConsultas({
    super.key,

    this.nome,
    this.servico,
    this.horario,
    this.status,
    this.onPressedHisotoricoPaciente,
    this.isAction,
    this.atedimento,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,

      color: ColorsConstants.primaryColor,
      shadowColor: ColorsConstants.appBarColor,

      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              horario ?? "",
              style: context.cusotomFontes.textBold.copyWith(
                color: ColorsConstants.letrasColor,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              nome ?? "",
              style: context.cusotomFontes.textBoldItalic.copyWith(
                color: ColorsConstants.letrasColor,
                fontSize: 14,
              ),
            ),
            Text(
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
            Text(
              atedimento != null && atedimento!.isNotEmpty
                  ? "$servico - $atedimento"
                  : "$servico",
              style: context.cusotomFontes.textBoldItalic.copyWith(
                color: ColorsConstants.letrasColor,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
