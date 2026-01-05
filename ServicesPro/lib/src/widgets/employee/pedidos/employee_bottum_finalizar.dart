import 'package:flutter/material.dart';
import 'package:servicespro/core/ui/style/custom_colors.dart';

class EmployeeBottumFinalizar extends StatelessWidget {
  final void Function()? onPressedFinalizar;
  const EmployeeBottumFinalizar({super.key, this.onPressedFinalizar});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      // padding: const EdgeInsets.only(top: 8.0, left: 8.0),
      child: TextButton(
        onPressed: onPressedFinalizar,

        child: Container(
          width: 130,
          height: 25,

          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: ColorsConstants.azulColor,
          ),

          child: Text("Finalizar"),
        ),
      ),
    );
  }
}
