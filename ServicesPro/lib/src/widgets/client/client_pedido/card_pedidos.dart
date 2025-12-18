import 'package:flutter/material.dart';
import 'package:servicespro/core/ui/style/custom_colors.dart';
import 'package:servicespro/core/ui/style/fontes_letras.dart';
import 'package:servicespro/core/ui/style/size_extension.dart';
import 'package:servicespro/src/widgets/client/client_pedido/buttom_ver_detalhes.dart';
import 'package:servicespro/src/widgets/client/client_pedido/button_acompanhar_cancelar.dart';
import 'package:servicespro/src/widgets/client/client_pedido/button_acompanhar_progresso.dart';

class CardPedidos extends StatelessWidget {
  final bool isDark;
  final void Function()? onPressedAcompanhar;
  final void Function()? onPressedCancelar;
  final void Function()? onPressedAcompanharProgresso;
  final void Function()? onPressedVerDetalhes;
  final String? statusPedido; //!o status vai dentro do model
  const CardPedidos({
    super.key,
    required this.isDark,
    this.onPressedAcompanhar,
    this.onPressedCancelar,
    this.statusPedido,
    this.onPressedAcompanharProgresso,
    this.onPressedVerDetalhes,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: context.percentWidth(0.9),

          child: Card(
            color: isDark
                ? Theme.of(context).colorScheme.surface
                : ColorsConstants.primaryColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: context.percentWidth(0.9),
                    height: 25,
                    padding: EdgeInsets.only(left: 10),
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: statusPedido == "AGUARDANDO"
                          ? ServiceColors.reformaConstrucao.withOpacity(0.3)
                          : statusPedido == "ANDAMENTO"
                          ? ColorsConstants.azulColor.withOpacity(0.3)
                          : statusPedido == "CANCELADO"
                          ? ColorsConstants.iconeErrorColor.withOpacity(0.3)
                          : ServiceColors.mudancaTransporte.withOpacity(0.3),
                    ),
                    child: Text(
                      statusPedido == "AGUARDANDO"
                          ? "AGUARDANDO"
                          : statusPedido == "ANDAMENTO"
                          ? "ANDAMENTO"
                          : "CONCLUÍDO",
                      style: context.cusotomFontes.bold.copyWith(
                        color: statusPedido == "AGUARDANDO"
                            ? ServiceColors.reformaConstrucao
                            : statusPedido == "ANDAMENTO"
                            ? ColorsConstants.azulColor
                            : statusPedido == "CANCELADO"
                            ? ColorsConstants.iconeErrorColor
                            : ServiceColors.mudancaTransporte,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                    child: Text(
                      "Categoria",
                      style: context.cusotomFontes.light.copyWith(fontSize: 14),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                    child: Text(
                      "Titulo completo do serviço.",
                      style: context.cusotomFontes.semiBold.copyWith(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                    child: Text(
                      "Data de solicitação",
                      style: context.cusotomFontes.light.copyWith(fontSize: 14),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                    child: Text(
                      "R\$Valor",
                      style: context.cusotomFontes.bold.copyWith(
                        fontSize: 16,
                        color: statusPedido == "CONCLUIDO"
                            ? ServiceColors.mudancaTransporte
                            : ColorsConstants.azulColor,
                      ),
                    ),
                  ),
                  statusPedido == "AGUARDANDO"
                      ? ButtonAcompanharCancelar(
                          onPressedAcompanhar: onPressedAcompanhar,
                          onPressedCancelar: onPressedCancelar,
                        )
                      : statusPedido == "ANDAMENTO"
                      ? Center(
                          child: ButtonAcompanharProgresso(
                            onPressedAcompanharProgresso:
                                onPressedAcompanharProgresso,
                          ),
                        )
                      : statusPedido == "CANCELADO"
                      ? SizedBox.shrink()
                      : Center(
                          child: ButtomVerDetalhes(
                            onPressedVerDetalhes: onPressedVerDetalhes,
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
