import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saborito/app/core/extensions/formatter_extension.dart';
import 'package:saborito/app/core/ui/Styles/text_styles.dart';
import 'package:saborito/app/core/ui/base_state/base_state.dart';
import 'package:saborito/app/core/ui/helpers/size_extensions.dart';

import 'package:saborito/app/core/ui/widgets/saboritos_app_bar.dart';
import 'package:saborito/app/core/ui/widgets/sbt_incremento_decremento_button.dart';
import 'package:saborito/app/dto/order_produto_dto.dart';
import 'package:saborito/app/models/produto_model.dart';
import 'package:saborito/app/page/produto_detail/produto_detail_controller.dart';
import 'package:saborito/app/rotas/rotas.dart';

class ProdutoDetailPage extends StatefulWidget {
  final ProdutoModel produto;
  final OrderProdutoDto? order;
  const ProdutoDetailPage({
    super.key,
    required this.produto,
    this.order,
  });

  @override
  State<ProdutoDetailPage> createState() => _ProdutoDetailPageState();
}

class _ProdutoDetailPageState
    extends BaseState<ProdutoDetailPage, ProdutoDetailController> {
  @override
  void initState() {
    super.initState();
    final amount = widget.order?.amount ?? 1;
    controller.initial(amount, widget.order != null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SaboritosAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: context.screenWidth,
            height: context.percentHight(.4),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(widget.produto.foto),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Text(
              widget.produto.nome,
              style: context.textStyles.textExtraBold.copyWith(
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: SingleChildScrollView(
                child: Text(
                  widget.produto.descricao,
                  style: context.textStyles.textMedium.copyWith(
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
          const Divider(color: Colors.grey),
          Row(
            children: [
              Container(
                width: context.percentWidth(.5),
                height: 68,
                padding: const EdgeInsets.all(8),
                child: BlocBuilder<ProdutoDetailController, int>(
                  builder: (context, amount) {
                    return SbtIncrementoDecrementoButton(
                      incrementoTap: () {
                        controller.incremento();
                      },
                      decrementoTap: () {
                        controller.decremento();
                      },
                      amout: amount,
                    );
                  },
                ),
              ),
              Container(
                width: context.percentWidth(.5),
                padding: const EdgeInsets.all(8),
                height: 68,
                child: BlocBuilder<ProdutoDetailController, int>(
                  builder: (context, amount) {
                    return ElevatedButton(
                      onPressed: () {
                        if (Navigator.of(context).canPop()) {
                          Navigator.of(context).pop(OrderProdutoDto(
                            produtos: widget.produto,
                            amount: amount,
                          ));
                        } else {
                          Navigator.of(context).pop(Rotas.home);
                        }

                        // Navigator.of(context).pop(Rotas.home);
                        // OrderProdutoDto(
                        //   amount: amount,
                        //   produtos: widget.produto,
                        // );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Adicionar',
                            style: context.textStyles.textExtraBold.copyWith(
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: AutoSizeText(
                              (widget.produto.preco * amount).currencyPTBR,
                              maxFontSize: 13,
                              minFontSize: 5,
                              maxLines: 1,
                              style: context.textStyles.textExtraBold.copyWith(
                                fontSize: 13,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
