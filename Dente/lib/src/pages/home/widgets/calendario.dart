import 'package:dente/core/ui/style/custom_colors.dart';
import 'package:dente/core/ui/style/fontes_letras.dart';
import 'package:flutter/material.dart';

class Calendario extends StatelessWidget {
  final void Function()? onPressedBack;
  final String labelMes;
  final void Function()? onPressedNext;
  final int? itemCount;
  final Widget? Function(BuildContext, int) itemBuilder;

  const Calendario({
    super.key,
    this.onPressedBack,
    required this.labelMes,
    this.onPressedNext,
    this.itemCount,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      color: ColorsConstants.primaryColor,
      shadowColor: ColorsConstants.appBarColor,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: 20,
                    color: ColorsConstants.appBarColor,
                  ),
                  onPressed: onPressedBack,
                ),
                Text(
                  labelMes,

                  style: context.cusotomFontes.textBoldItalic.copyWith(
                    color: ColorsConstants.appBarColor,
                    fontSize: 20,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                    color: ColorsConstants.appBarColor,
                  ),
                  onPressed: onPressedNext,
                ),
              ],
            ),
          ),
          Row(
            children: ['D', 'S', 'T', 'Q', 'Q', 'S', 'S']
                .map(
                  (d) => Expanded(
                    child: Center(
                      child: Text(
                        d,
                        style: context.cusotomFontes.textRegular.copyWith(
                          color: ColorsConstants.appBarColor,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          Expanded(
            child: GridView.builder(
              shrinkWrap: true,
              // physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                crossAxisSpacing: 6,
                mainAxisSpacing: 6,
              ),

              itemCount: itemCount,
              itemBuilder: itemBuilder,
            ),
          ),
        ],
      ),
    );
  }
}
