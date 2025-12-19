import 'package:flutter/material.dart';
import 'package:servicespro/core/ui/style/fontes_letras.dart';
import 'package:servicespro/core/ui/style/size_extension.dart';

class CustomContainerCategorias extends StatelessWidget {
  final bool isDark;
  final String image;
  final String label;
  final Function()? onTap;
  const CustomContainerCategorias({
    super.key,
    required this.isDark,
    required this.image,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            width: context.percentWidth(0.9),
            height: 60,
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
                Image.asset(image, width: 40, height: 40),
                SizedBox(
                  width: context.percentWidth(0.5),
                  child: Text(
                    label,
                    style: context.cusotomFontes.semiBold.copyWith(
                      fontSize: 16,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Icon(Icons.arrow_circle_right_outlined),
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
        //     height: 3,
        //   ),
        // ),
        const SizedBox(height: 14),
      ],
    );
  }
}
