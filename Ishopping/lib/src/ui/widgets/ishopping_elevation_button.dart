import 'package:flutter/material.dart';
import 'package:ishopping/src/ui/colors/colors_constants.dart';

import 'package:ishopping/src/ui/extensions/size_screen.dart';
import 'package:ishopping/src/ui/fonts/fontes_constants.dart';

class IshoppingElevationButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  const IshoppingElevationButton({
    super.key,
    required this.label,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.screenMetWidth(0.8),
      height: 50,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(ColorsConstants.button),
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: context.fontes.textBold.copyWith(
            fontSize: 14,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
