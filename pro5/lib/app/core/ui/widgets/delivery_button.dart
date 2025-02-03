import 'package:delivery/app/core/ui/style/colors_app.dart';
import 'package:flutter/material.dart';

class DeliveryButton extends StatelessWidget {
  final String label; //click do botõa
  final VoidCallback? onPressed; //texto dentro do botão

  final double? width; //tamnho do botão
  final double? height;

  const DeliveryButton(
      {super.key,
      required this.label,
      this.onPressed,
      this.height = 50,
      this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width, // definir o tamanho do botão
        height: height,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(ColorsApp.i.primary),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          ),
          onPressed: onPressed,
          child: Text(label),
        ));
  }
}
