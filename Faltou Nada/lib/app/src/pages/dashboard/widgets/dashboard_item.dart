import 'package:faltou_nada/app/core/ui/style/custom_colors.dart';
import 'package:faltou_nada/app/core/ui/style/fontes_letras.dart';
import 'package:flutter/material.dart';

class DashboardItem extends StatelessWidget {
  final Map<String, dynamic>? item;
  const DashboardItem({super.key, this.item});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 160,
          child: Text(
            item!['descricao'] ?? "",
            style: context.fontesLetras.textLight.copyWith(
              color: ColorsConstants.black,
              fontSize: 12,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        Text(
          item!['unid'].toString(),
          style: context.fontesLetras.textLight.copyWith(
            color: ColorsConstants.black,
            fontSize: 12,
          ),
        ),
        SizedBox(
          width: 30,
          child: Text(
            item!['qtde'].toString(),
            textAlign: TextAlign.center,
            style: context.fontesLetras.textLight.copyWith(
              color: ColorsConstants.black,
              fontSize: 12,
            ),
          ),
        ),
        Text(
          item!['un'],
          style: context.fontesLetras.textLight.copyWith(
            color: ColorsConstants.black,
            fontSize: 12,
          ),
        ),
        Text(
          item!['total'].toString(),
          style: context.fontesLetras.textLight.copyWith(
            color: ColorsConstants.black,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
