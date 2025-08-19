import 'package:faltou_nada/app/core/ui/style/custom_colors.dart';
import 'package:faltou_nada/app/core/ui/style/fontes_letras.dart';
import 'package:flutter/material.dart';

class DashboardUrl extends StatelessWidget {
  final String? url;
  const DashboardUrl({super.key, this.url});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(top: 15, left: 10, right: 10),
      decoration: BoxDecoration(
        color: ColorsConstants.appBar.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: ColorsConstants.appBar.withValues(alpha: 0.5),
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.error_outline_rounded,
            color: ColorsConstants.appBar,
            size: 24,
          ),
          const SizedBox(width: 12),
          Flexible(
            child: Text(
              url ?? "",
              style: context.fontesLetras.textRegular.copyWith(
                color: ColorsConstants.appBar,
                fontWeight: FontWeight.w500,
                overflow: TextOverflow.visible,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
