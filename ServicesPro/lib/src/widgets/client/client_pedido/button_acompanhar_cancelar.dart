import 'package:flutter/material.dart';
import 'package:servicespro/core/ui/style/custom_colors.dart';

class ButtonAcompanharCancelar extends StatelessWidget {
  final void Function()? onPressedAcompanhar;
  final void Function()? onPressedCancelar;
  const ButtonAcompanharCancelar({
    super.key,
    this.onPressedAcompanhar,
    this.onPressedCancelar,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      // padding: const EdgeInsets.only(top: 8.0, left: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: onPressedAcompanhar,

            child: Container(
              width: 130,
              height: 25,

              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: ColorsConstants.azulColor,
              ),

              child: Text("Acompanhar"),
            ),
          ),
          TextButton(
            onPressed: onPressedCancelar,
            child: Container(
              width: 130,
              height: 25,

              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: ColorsConstants.iconeErrorColor,
              ),
              child: Text("Cancelar"),
            ),
          ),
        ],
      ),
    );
  }
}
