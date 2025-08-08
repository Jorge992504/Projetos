import 'package:faltou_nada/app/core/ui/style/custom_colors.dart';
import 'package:faltou_nada/app/src/models/product_model.dart';
import 'package:flutter/material.dart';

class HomeItem extends StatelessWidget {
  final double? width;
  final double? height;
  final ProductModel product;
  const HomeItem({super.key, this.width, this.height, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 65,
      height: height ?? 59,
      decoration: ShapeDecoration(
        color: const Color(0xFFE7DFD4),
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            width: 2,
            strokeAlign: BorderSide.strokeAlignOutside,
            color: ColorsConstants.buttonBordas,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        shadows: const [
          BoxShadow(
            color: ColorsConstants.appBar,
            blurRadius: 4,
            offset: Offset(0, 6),
            spreadRadius: 1,
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(product.name),
          const SizedBox(
            height: 5,
          ),
          Image.network(
            product.photo,
            fit: BoxFit.cover,
            width: 50,
            height: 50,
          ),
        ],
      ),
    );
  }
}
