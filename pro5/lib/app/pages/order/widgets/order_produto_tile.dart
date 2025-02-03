import 'package:delivery/app/core/extensions/formater_extension.dart';

import 'package:delivery/app/core/ui/style/colors_app.dart';
import 'package:delivery/app/core/ui/style/text_styles.dart';

import 'package:delivery/app/core/ui/widgets/delivery_increment_decrement_button.dart';

import 'package:delivery/app/dto/ordem_produto_dto.dart';
import 'package:delivery/app/pages/order/order_controller.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderProdutoTile extends StatelessWidget {
  final int index;
  final OrdemProduto orderProdutoDto;

  const OrderProdutoTile(
      {super.key, required this.index, required this.orderProdutoDto});

  @override
  Widget build(BuildContext context) {
    final produto = orderProdutoDto.product;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Image.network(
            produto.image,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    produto.name,
                    style:
                        context.textStyles.textRegular.copyWith(fontSize: 16),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        (orderProdutoDto.cont * produto.price).currencyPTBR,
                        style: context.textStyles.textMedium.copyWith(
                            fontSize: 14, color: context.colors.secundary),
                      ),
                      ButtonIncrementarDecrementar.compact(
                        cont: orderProdutoDto.cont,
                        incrementar: () {
                          context
                              .read<OrderController>()
                              .incrementProduto(index);
                        },
                        decrementar: () {
                          context
                              .read<OrderController>()
                              .decrementarProduto(index);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
