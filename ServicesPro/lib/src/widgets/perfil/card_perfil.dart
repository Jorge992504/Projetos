import 'package:flutter/material.dart';
import 'package:servicespro/core/ui/style/custom_colors.dart';
import 'package:servicespro/core/ui/style/fontes_letras.dart';
import 'package:servicespro/core/ui/style/size_extension.dart';

class CardPerfil extends StatelessWidget {
  final bool isDark;
  final String titulo;
  final String descricao;
  final Icon? iconeTitulo;
  final Color? backgroundColor;
  const CardPerfil({
    super.key,
    required this.isDark,
    required this.titulo,
    required this.descricao,
    this.iconeTitulo,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.percentWidth(1),
      child: Card(
        color: isDark
            ? Theme.of(context).colorScheme.surface
            : ColorsConstants.primaryColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                backgroundColor:
                    backgroundColor ??
                    ColorsConstants.secundaryColor.withOpacity(0.15),
                radius: 25,
                child:
                    iconeTitulo ??
                    Icon(
                      Icons.dashboard_sharp,
                      size: 30,
                      color: ColorsConstants.azulColor,
                    ),
              ),
              SizedBox(
                width: 260,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text(
                      titulo,
                      style: context.cusotomFontes.bold.copyWith(fontSize: 14),
                    ),
                    Text(
                      descricao,
                      style: context.cusotomFontes.regular.copyWith(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 20,
                color: ColorsConstants.azulColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
