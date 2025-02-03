import 'package:delivery/app/core/extensions/formater_extension.dart';
import 'package:delivery/app/core/ui/style/colors_app.dart';
import 'package:delivery/app/core/ui/style/text_styles.dart';
import 'package:delivery/app/dto/ordem_produto_dto.dart';
import 'package:delivery/app/models/prod_mod.dart';
import 'package:delivery/app/pages/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeliveryProductTile extends StatelessWidget {
  final ProdMod product;
  final OrdemProduto?
      retorno2; //pega a quantidade de produtos do botao autoincremento
  const DeliveryProductTile({super.key, required this.product, this.retorno2});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      //click na tela e add produto na sacola
      onTap: () async {
        final controller = context.read<HomeController>();
        final retorno = await Navigator.of(context).pushNamed('/productDetail',
            arguments: {'product': product, 'order': retorno2});
        if (retorno != null) {
          controller.addOrUpdateBag(retorno as OrdemProduto);
        }
      },
      child: Padding(
        //coloca varios componentes
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              //deixa as imagens para a esquerda
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start, //alinhado ao canto
                children: [
                  Padding(
                      //desgruda os itens(deixa espaço entre eles)
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        product.name, //nome na tela
                        style: context.textStyles.textExtraBold
                            .copyWith(fontSize: 16),
                      )),
                  Padding(
                      //desgruda os itens(deixa espaço entre eles)
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        product.description, //descrição na tela
                        style:
                            context.textStyles.textLight.copyWith(fontSize: 12),
                      )),
                  Padding(
                      //desgruda os itens(deixa espaço entre eles)
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        product.price.currencyPTBR, //preço na tela
                        style: context.textStyles.textMedium.copyWith(
                            fontSize: 11, color: context.colors.secundary),
                      ))
                ],
              ),
            ),
            FadeInImage.assetNetwork(
              //carregar as imagens na tela de cada produto
              placeholder: 'assets/images/loading.gif', //imagen de loading
              image: product.image, //add uma image ao produto
              width: 100,
              height: 100,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }
}
