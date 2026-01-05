import 'package:flutter/material.dart';
import 'package:servicespro/core/ui/style/custom_colors.dart';
import 'package:servicespro/core/ui/style/fontes_letras.dart';
import 'package:servicespro/core/ui/style/size_extension.dart';
import 'package:servicespro/core/ui/widgets/tema_sistema.dart';

class ContainerServicosDisponiveis extends StatelessWidget {
  final String categoria;
  final String servico;
  final String descricaoServico;
  final void Function()? onPressedDetalhes;
  const ContainerServicosDisponiveis({
    super.key,
    required this.categoria,
    required this.servico,
    required this.descricaoServico,
    this.onPressedDetalhes,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.percentWidth(0.9),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: TemaSistema().temaSistema(context)
            ? Theme.of(context).colorScheme.surface
            : ColorsConstants.primaryColor,
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            // width: context.percentWidth(0.9),
            decoration: BoxDecoration(
              color: ServiceColors.reformaConstrucao.withOpacity(0.9),
            ),
            height: 30,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.workspace_premium_outlined,
                    color: ColorsConstants.primaryColor,
                    size: 20,
                  ),
                  SizedBox(width: 8),
                  Text(
                    "Tarefa Urgente",
                    style: TextStyle(
                      color: ColorsConstants.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 8.0),
            child: Text(
              categoria,
              style: context.cusotomFontes.semiBold.copyWith(
                color: ColorsConstants.secundaryColor,
                fontSize: 14,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 4.0),
            child: Text(
              servico,
              style: context.cusotomFontes.bold.copyWith(
                color: TemaSistema().temaSistema(context)
                    ? ColorsConstants.primaryColor
                    : ColorsConstants.letrasColor,
                fontSize: 15,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 4.0, bottom: 8.0),
            child: Text(
              descricaoServico,
              style: context.cusotomFontes.semiBold.copyWith(
                color: TemaSistema().temaSistema(context)
                    ? ColorsConstants.primaryColor.withOpacity(0.3)
                    : ColorsConstants.letrasColor.withOpacity(0.3),
                fontSize: 15,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: TextButton(
              onPressed: onPressedDetalhes,
              child: Text(
                "Ver detalhes",
                style: context.cusotomFontes.medium.copyWith(
                  color: ColorsConstants.secundaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
