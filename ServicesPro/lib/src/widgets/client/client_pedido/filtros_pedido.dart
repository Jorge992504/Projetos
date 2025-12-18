import 'package:flutter/material.dart';
import 'package:servicespro/core/ui/style/custom_colors.dart';
import 'package:servicespro/core/ui/style/fontes_letras.dart';
import 'package:servicespro/core/ui/style/size_extension.dart';

class FiltrosPedido extends StatelessWidget {
  final int isSelec;
  final void Function()? onPressedAbertos;
  final void Function()? onPressedEmAndamento;
  final void Function()? onPressedFinalizados;
  const FiltrosPedido({
    super.key,
    required this.isSelec,
    this.onPressedAbertos,
    this.onPressedEmAndamento,
    this.onPressedFinalizados,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        Container(
          width: context.percentWidth(0.9),
          height: 40,
          // padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: isDark
                ? Theme.of(context).colorScheme.surface
                : ColorsConstants.secundaryColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 100,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: isDark && isSelec == 1
                      ? ColorsConstants.secundaryColor
                      : isDark && isSelec != 1
                      ? Theme.of(context).colorScheme.surface
                      : !isDark && isSelec == 1
                      ? ColorsConstants.azulColor
                      : ColorsConstants.secundaryColor,
                ),
                child: TextButton(
                  onPressed: onPressedAbertos,
                  child: Text('Abertos', style: context.cusotomFontes.bold),
                ),
              ),
              Container(
                width: 150,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: isDark && isSelec == 2
                      ? ColorsConstants.secundaryColor
                      : isDark && isSelec != 2
                      ? Theme.of(context).colorScheme.surface
                      : !isDark && isSelec == 2
                      ? ColorsConstants.azulColor
                      : ColorsConstants.secundaryColor,
                ),
                child: TextButton(
                  onPressed: onPressedEmAndamento,
                  child: Text(
                    'Em andamento',
                    style: context.cusotomFontes.bold,
                  ),
                ),
              ),
              Container(
                width: 100,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: isDark && isSelec == 3
                      ? ColorsConstants.secundaryColor
                      : isDark && isSelec != 3
                      ? Theme.of(context).colorScheme.surface
                      : !isDark && isSelec == 3
                      ? ColorsConstants.azulColor
                      : ColorsConstants.secundaryColor,
                ),
                child: TextButton(
                  onPressed: onPressedFinalizados,
                  child: Text('Finalizados', style: context.cusotomFontes.bold),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
