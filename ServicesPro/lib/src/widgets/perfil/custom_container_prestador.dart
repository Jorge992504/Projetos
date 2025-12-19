import 'package:flutter/material.dart';
import 'package:servicespro/core/ui/style/fontes_letras.dart';
import 'package:servicespro/core/ui/style/size_extension.dart';

class CustomContainerPrestador extends StatelessWidget {
  final bool isDark;
  final Widget image;
  final Widget avaliacao;
  final String label;
  final String categoria;
  final Function()? onTap;
  const CustomContainerPrestador({
    super.key,
    required this.isDark,
    required this.image,
    required this.label,
    this.onTap,
    required this.avaliacao,
    required this.categoria,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            width: context.percentWidth(0.9),
            height: 70,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: isDark
                  ? Theme.of(context).colorScheme.surface
                  : Theme.of(context).colorScheme.onSecondary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                image,
                SizedBox(
                  width: context.percentWidth(0.5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        label,
                        style: context.cusotomFontes.black.copyWith(
                          fontSize: 14,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        categoria,
                        style: context.cusotomFontes.regular.copyWith(
                          fontSize: 14,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      avaliacao,
                    ],
                  ),
                ),
                Icon(Icons.message_outlined),
              ],
            ),
          ),
        ),
        // SizedBox(
        //   width: context.percentWidth(0.85),
        //   child: Divider(
        //     color: isDark
        //         ? ColorsConstants.primaryColor
        //         : ColorsConstants.letrasColor,
        //     height: 2,
        //   ),
        // ),
        const SizedBox(height: 14),
      ],
    );
  }
}
