import 'package:flutter/material.dart';
import 'package:nahora/app/core/ui/style/custom_colors.dart';
import 'package:nahora/app/core/ui/style/fontes_letras.dart';

class CustomStackHome extends StatelessWidget {
  final String? labelText;
  final Widget? image;
  const CustomStackHome({super.key, this.labelText, this.image});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            width: 100,
            height: 55,
            padding: EdgeInsets.only(top: 5),
            child: Text(
              labelText ?? "",
              style: context.cusotomFontes.textBold.copyWith(
                color: ColorsConstants.letrasColor,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.visible,
            ),
          ),
        ),

        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: 80,
            height: 80,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 5),
            decoration: ShapeDecoration(shape: OvalBorder()),
            child: image,
          ),
        ),
      ],
    );
  }
}
