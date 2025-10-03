import 'package:flutter/material.dart';
import 'package:nahora/app/core/ui/style/custom_colors.dart';
import 'package:nahora/app/core/ui/style/custom_images.dart';
import 'package:nahora/app/core/ui/style/fontes_letras.dart';

class CustomButtomCarrinho extends StatelessWidget {
  final String? total;
  const CustomButtomCarrinho({super.key, this.total});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          total ?? '0.0',
          style: context.cusotomFontes.textBold.copyWith(
            fontSize: 16,
            color: ColorsConstants.buttonColor,
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          width: 150,
          height: 50,
          margin: EdgeInsets.only(left: 10),
          child: ElevatedButton(
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Carrinho',
                  style: context.cusotomFontes.textExtraBold.copyWith(
                    color: ColorsConstants.letrasColor,
                  ),
                ),
                Image.asset(ImageConstants.car, fit: BoxFit.cover),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
