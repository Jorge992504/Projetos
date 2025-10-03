import 'package:flutter/material.dart';
import 'package:nahora/app/core/ui/style/custom_colors.dart';
import 'package:nahora/app/core/ui/style/custom_images.dart';
import 'package:nahora/app/core/ui/style/fontes_letras.dart';

class CustomButtonsAddRemove extends StatelessWidget {
  final String? labelCount;
  final Widget? childAdd;
  final Function()? onTapRemove;
  final Function()? onTapAdd;
  const CustomButtonsAddRemove({
    super.key,
    this.labelCount,
    this.childAdd,
    this.onTapRemove,
    this.onTapAdd,
  });

  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              splashColor: ColorsConstants.buttonColor,

              onTap: onTapRemove,
              child: Image.asset(
                ImageConstants.remove,
                width: 23,
                height: 23,
                color: brightness == Brightness.light
                    ? ColorsConstants.letrasColor
                    : ColorsConstants.primaryColor,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Container(
          width: 23,
          height: 23,
          alignment: Alignment.center,
          child: Text(
            labelCount ?? '0',
            style: context.cusotomFontes.textExtraBold.copyWith(fontSize: 16),
          ),
        ),
        Container(
          // padding: EdgeInsets.only(right: 3),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              splashColor: ColorsConstants.buttonColor,
              onTap: onTapAdd,
              child: childAdd,
            ),
          ),
        ),
      ],
    );
  }
}
