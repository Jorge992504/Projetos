import 'package:flutter/material.dart';
import 'package:servicespro/core/ui/style/custom_colors.dart';
import 'package:servicespro/core/ui/style/fontes_letras.dart';
import 'package:servicespro/core/ui/style/size_extension.dart';

class CardServico extends StatelessWidget {
  final String categoria;
  final int idCategoria;
  final String titulo;
  final String preco;
  const CardServico({
    super.key,
    required this.categoria,
    required this.idCategoria,
    required this.titulo,
    required this.preco,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        Container(
          height: 120,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: isDark
                  ? ColorsConstants.primaryColor
                  : ColorsConstants.azulColor,
            ),
            borderRadius: BorderRadius.circular(18),
            color: isDark
                ? Theme.of(context).colorScheme.surface
                : ColorsConstants.primaryColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: context.percentWidth(0.9),
                  height: 30,
                  padding: EdgeInsets.only(left: 10, top: 5, bottom: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: idCategoria == 1
                        ? ServiceColors.servicosDomesticos.withOpacity(0.15)
                        : ServiceColors.belezaEstetica.withOpacity(0.15),
                  ),
                  child: Text(
                    categoria,
                    style: context.cusotomFontes.regular.copyWith(
                      color: idCategoria == 1
                          ? ServiceColors.servicosDomesticos
                          : ServiceColors.belezaEstetica,
                      fontSize: 14,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    titulo,
                    style: context.cusotomFontes.medium.copyWith(
                      color: isDark
                          ? ColorsConstants.primaryColor
                          : ColorsConstants.letrasColor,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(
                    preco,
                    style: context.cusotomFontes.black.copyWith(
                      color: ColorsConstants.azulColor,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 14),
      ],
    );
  }
}
