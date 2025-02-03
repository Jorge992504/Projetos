import 'package:flutter/material.dart';

import 'package:saborito/app/core/ui/Styles/colors.dart';
import 'package:saborito/app/core/ui/Styles/text_styles.dart';

class SbtIncrementoDecrementoButton extends StatelessWidget {
  final int amout;
  final VoidCallback incrementoTap;
  final VoidCallback decrementoTap;
  const SbtIncrementoDecrementoButton({
    super.key,
    required this.amout,
    required this.incrementoTap,
    required this.decrementoTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: decrementoTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                '-',
                style: context.textStyles.textMedium.copyWith(
                  fontSize: 22,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          Text(
            amout.toString(),
            style: context.textStyles.textRegular.copyWith(
              fontSize: 17,
              color: context.colors.secondary,
            ),
          ),
          InkWell(
            onTap: incrementoTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                '+',
                style: context.textStyles.textMedium.copyWith(
                  fontSize: 22,
                  color: context.colors.secondary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
