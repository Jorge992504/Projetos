// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:delivery/app/core/extensions/formater_extension.dart';
import 'package:delivery/app/core/ui/style/text_styles.dart';
import 'package:flutter/material.dart';

import 'package:delivery/app/core/ui/helpers/size_extensions.dart';
import 'package:delivery/app/dto/ordem_produto_dto.dart';

class ShoppingBag extends StatelessWidget {
  final List<OrdemProduto> bag;
  const ShoppingBag({super.key, required this.bag});

  @override
  Widget build(BuildContext context) {
    var totalBag = bag
        .fold<double>(0.0, (total, element) => total += element.totalPreco)
        .currencyPTBR;
    return Container(
      width: context.screenWidth,
      height: 90,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 5,
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(7),
          topRight: Radius.circular(7),
        ),
      ),
      child: ElevatedButton(
        onPressed: () {},
        child: Stack(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Icon(
                Icons.shopping_cart_outlined,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Ver sacola',
                style: context.textStyles.textExtraBold.copyWith(fontSize: 14),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                totalBag,
                style: context.textStyles.textExtraBold.copyWith(fontSize: 11),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
