import 'package:faltou_nada/app/core/ui/style/custom_colors.dart';
import 'package:faltou_nada/app/core/ui/style/fontes_letras.dart';
import 'package:flutter/material.dart';

class DashboardCabecalho extends StatelessWidget {
  const DashboardCabecalho({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 160,
          child: Text(
            "Descrição",
            style: context.fontesLetras.textLight.copyWith(
              color: ColorsConstants.black,
              fontSize: 14,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        Text(
          "Unit",
          style: context.fontesLetras.textLight.copyWith(
            color: ColorsConstants.black,
            fontSize: 14,
          ),
        ),
        Text(
          "Qtde",
          style: context.fontesLetras.textLight.copyWith(
            color: ColorsConstants.black,
            fontSize: 14,
          ),
        ),
        Text(
          "UN",
          style: context.fontesLetras.textLight.copyWith(
            color: ColorsConstants.black,
            fontSize: 14,
          ),
        ),
        Text(
          "Total",
          style: context.fontesLetras.textLight.copyWith(
            color: ColorsConstants.black,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
