import 'package:flutter/material.dart';
import 'package:servicespro/core/ui/style/custom_colors.dart';
import 'package:servicespro/core/ui/style/fontes_letras.dart';
import 'package:servicespro/core/ui/style/size_extension.dart';

class CardHistoricoServico extends StatelessWidget {
  final bool isDark;
  //! enviar os dados do model
  const CardHistoricoServico({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.percentWidth(1),
      height: 130,
      child: Card(
        color: isDark
            ? Theme.of(context).colorScheme.surface
            : ColorsConstants.primaryColor,
        elevation: 7,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8, top: 8),
                child: Text(
                  "Titulo completo do serviço",
                  style: context.cusotomFontes.black.copyWith(fontSize: 18),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 8, top: 8),
                child: Text(
                  "Categoria • Nome prestador",
                  style: context.cusotomFontes.regular.copyWith(fontSize: 14),
                ),
              ),
              const SizedBox(height: 14),
              Container(
                width: context.percentWidth(0.4),
                height: 25,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: ColorsConstants.azulColor.withOpacity(0.6),
                ),

                child: Text(
                  "Em andamento",
                  style: context.cusotomFontes.bold.copyWith(
                    color: ColorsConstants.primaryColor,
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
