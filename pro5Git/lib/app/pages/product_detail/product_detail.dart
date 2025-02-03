import 'package:auto_size_text/auto_size_text.dart';
import 'package:delivery/app/core/extensions/formater_extension.dart';
import 'package:delivery/app/core/ui/base_state/base_state.dart';
import 'package:delivery/app/core/ui/helpers/size_extensions.dart';
import 'package:delivery/app/core/ui/style/text_styles.dart';
import 'package:delivery/app/core/ui/widgets/delivery_appbar.dart';
import 'package:delivery/app/core/ui/widgets/delivery_increment_decrement_button.dart';
import 'package:delivery/app/dto/ordem_produto_dto.dart';
import 'package:delivery/app/models/prod_mod.dart';
import 'package:delivery/app/pages/product_detail/product_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailPage extends StatefulWidget {
  final ProdMod product;
  final OrdemProduto? order;
  const ProductDetailPage(
      {super.key, required this.product, required this.order});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState
    extends BaseState<ProductDetailPage, ControlarProdutos> {
  @override
  void initState() {
    super.initState();
    final cont = widget.order?.cont ?? 1;
    controller.initial(cont, widget.order != null);
  }

  void _showConfirmarDelete(int cont) {
    showDialog(
      context: context,
      barrierDismissible: false, //para q o usuario tenha q escolher uma opcao
      builder: (context) {
        return AlertDialog(
          title: const Text('Deseja excluir o produto?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancelar',
                style: context.textStyles.textBold.copyWith(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.of(context)
                    .pop(OrdemProduto(product: widget.product, cont: cont));
              },
              child: Text(
                'Confirmar',
                style:
                    context.textStyles.textBold.copyWith(color: Colors.green),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DeliveryAppbar(),
      body: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start, //deja todo alinhado na esquerda
        children: [
          Container(
            //dentro do container deixa a imagem do tamanho da tela
            width: context.screenWidth,
            height: context.percentHeight(.4),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(widget.product
                        .image), //depois do usuario clickar na imagem da tela esta aparece nesta tela
                    fit: BoxFit.cover //mantiene a proporção da imagem
                    )),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 10), //coloca espaçamento de 10 na esquerda
            child: Text(
              widget.product.name,
              style: context.textStyles.textExtraBold.copyWith(fontSize: 18),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SingleChildScrollView(
                child: Text(
                  widget.product.description,
                  style: context.textStyles.textLight.copyWith(fontSize: 12),
                ),
              ),
            ),
          ),
          const Divider(), //faz uma linha divisoria
          Row(
            //os dois botões
            children: [
              Container(
                //deixa o botao do do tamanho do outro
                width: context.percentWidth(.5),
                height: 68,
                padding: const EdgeInsets.all(8),
                child: BlocBuilder<ControlarProdutos, int>(
                  builder: (context, cont) {
                    return ButtonIncrementarDecrementar(
                      decrementar: controller.decrementar,
                      incrementar: controller.incrementar,
                      cont: cont,
                    );
                  },
                ),
              ),
              Container(
                // contiene o botao e os dois textos dentro deste
                width: context.percentWidth(.5),
                height: 68,
                padding: const EdgeInsets.all(8),
                child: BlocBuilder<ControlarProdutos, int>(
                  //vai pegar os dados da tela e mover para a outra
                  builder: (context, cont) {
                    return ElevatedButton(
                      style: cont == 0
                          ? ElevatedButton.styleFrom(
                              backgroundColor: Colors.red)
                          : null,
                      onPressed: () {
                        //espera um retorno da outra tela
                        // Navigator.of(context).pop(
                        //   OrdemProduto(product: widget.product, cont: cont),
                        // );
                        if (cont == 0) {
                          _showConfirmarDelete(cont);
                        } else {
                          Navigator.of(context).pop(
                            OrdemProduto(product: widget.product, cont: cont),
                          );
                        }
                      },
                      child: Visibility(
                        //muda o botao
                        visible: cont >
                            0, //se o numero de produtos for > 0 mostra o botao adicionar
                        replacement: Text(
                          //se o numero de produtos for < 0 mostra o botao excluir
                          'Excluir produto',
                          style: context.textStyles.textExtraBold,
                        ),
                        child: Row(
                          //cria dois textos dentro do botao
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Adicionar',
                              style: context.textStyles.textExtraBold
                                  .copyWith(fontSize: 13),
                            ),
                            const SizedBox(
                              //separa os dois textos
                              width: 10,
                            ),
                            Expanded(
                              // evita q a tela quebre se  campo for maios, import auto_size_text
                              child: AutoSizeText(
                                (widget.product.price * cont).currencyPTBR,
                                maxFontSize: 15,
                                minFontSize: 5,
                                maxLines: 1,
                                style: context.textStyles.textExtraBold,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          // FloatingActionButton(onPressed: () async {
          //   //button para voltar
          //   Navigator.of(context).popAndPushNamed('/');
          // }),
        ],
      ),
    );
  }
}
