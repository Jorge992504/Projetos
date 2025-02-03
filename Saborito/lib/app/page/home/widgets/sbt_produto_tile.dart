import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saborito/app/core/extensions/formatter_extension.dart';

import 'package:saborito/app/core/ui/Styles/colors.dart';

import 'package:saborito/app/core/ui/Styles/text_styles.dart';
import 'package:saborito/app/dto/order_produto_dto.dart';

import 'package:saborito/app/models/produto_model.dart';
import 'package:saborito/app/page/home/home_controller.dart';

class SbtProdutoTile extends StatelessWidget {
  final ProdutoModel produto;
  final OrderProdutoDto? orderProduto;
  const SbtProdutoTile(
      {super.key, required this.produto, required this.orderProduto});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final controller = context.read<HomeController>();
        final orderProdutoResult =
            await Navigator.of(context).pushNamed('/produtoDetail', arguments: {
          'produto': produto,
          'order': orderProduto,
        });
        if (orderProdutoResult != null &&
            orderProdutoResult is OrderProdutoDto) {
          controller.addUpdateBag(orderProdutoResult);
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      produto.nome,
                      style: context.textStyles.textExtraBold.copyWith(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      produto.descricao,
                      style: context.textStyles.textRegular.copyWith(
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      produto.preco.currencyPTBR,
                      style: context.textStyles.textMedium.copyWith(
                        fontSize: 12,
                        color: ColorsApp.i.secondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            FadeInImage.assetNetwork(
              placeholder: 'assets/imagens/loading.gif',
              image: produto.foto,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}
