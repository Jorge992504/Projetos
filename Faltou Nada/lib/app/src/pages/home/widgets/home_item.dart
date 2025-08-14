import 'package:faltou_nada/app/core/ui/style/custom_colors.dart';
import 'package:faltou_nada/app/core/ui/style/fontes_letras.dart';
import 'package:faltou_nada/app/src/models/product_model.dart';
import 'package:flutter/material.dart';

class HomeItem extends StatelessWidget {
  final double? width;
  final double? height;
  final ProductModel product;
  final Function()? onTap;
  const HomeItem({
    super.key,
    this.width,
    this.height,
    required this.product,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width ?? 80,
        height: height ?? 80,
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
            Container(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Text(
                product.nome,
                style: context.fontesLetras.textExtraLight.copyWith(
                  fontSize: 12,
                  color: ColorsConstants.black,
                ),
                overflow: TextOverflow.visible,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Flexible(
              child: Image.network(
                product.foto,
                fit: BoxFit.cover,
                // width: 30,
                // height: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
