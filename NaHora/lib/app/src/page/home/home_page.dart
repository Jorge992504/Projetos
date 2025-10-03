import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nahora/app/core/router/rotas.dart';
import 'package:nahora/app/core/ui/base/base_state.dart';
import 'package:nahora/app/core/ui/style/custom_colors.dart';
import 'package:nahora/app/core/ui/style/custom_images.dart';
import 'package:nahora/app/core/ui/style/fontes_letras.dart';
import 'package:nahora/app/core/ui/style/size_extension.dart';
import 'package:nahora/app/src/models/produto_model.dart';
import 'package:nahora/app/src/models/request/sacola_model_request.dart';
import 'package:nahora/app/src/models/response/promocoes_model_response.dart';
import 'package:nahora/app/src/page/home/home_controller.dart';
import 'package:nahora/app/src/page/home/home_state.dart';
import 'package:nahora/app/src/page/home/widgets/custom_stack_home.dart';
import 'package:nahora/app/src/widgets/custom_buttom_carrinho.dart';
import 'package:nahora/app/src/widgets/custom_buttons_add_remove.dart';
import 'package:nahora/app/src/widgets/custom_campo_item.dart';
import 'package:nahora/app/src/widgets/custom_item.dart';
import 'package:nahora/app/src/widgets/custom_rectangle.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends BaseState<HomePage, HomeController> {
  @override
  void onReady() {
    super.onReady();
    controller.buscaPromocoesGerais();
  }

  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          Container(
            padding: EdgeInsets.only(right: 5),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(8),
                splashColor: ColorsConstants.buttonColor,
                onTap: () {},
                child: Image.asset(
                  ImageConstants.user,
                  width: 30,
                  height: 30,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
      body: BlocConsumer<HomeController, HomeState>(
        listener: (context, state) {
          state.status.matchAny(
            any: hideLoader,
            loading: showLoader,
            loaded: hideLoader,
            refresh: hideLoader,
            // atualizaSacola: hideLoader,
            // removerProduto: hideLoader,
            failure: () {
              showError(state.errorMessage ?? 'INTERNAL_ERROR');
              hideLoader();
            },
          );
        },
        builder: (context, state) {
          List<PromocoesModelResponse>? promocoesGerais = state.promocoesGerais;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                  child: SizedBox(
                    width: context.percentWidth(1),
                    height: 120,
                    child: Wrap(
                      spacing: 8,
                      crossAxisAlignment: WrapCrossAlignment.center,

                      alignment: WrapAlignment.spaceAround,
                      children: [
                        CustomRectangle(
                          width: 120,
                          height: 120,
                          child: CustomStackHome(
                            labelText: 'Carnes',
                            image: Image.asset(
                              ImageConstants.meat,
                              fit: BoxFit.cover,
                            ),
                          ),
                          onTap: () async {
                            await Navigator.of(context).pushNamed(
                              Rotas.menu,
                              arguments: {'menu': 2, 'sacola': state.sacola},
                            );
                          },
                        ),
                        CustomRectangle(
                          width: 120,
                          height: 120,
                          child: CustomStackHome(
                            labelText: 'Vegano',
                            image: Image.asset(
                              ImageConstants.salad,
                              fit: BoxFit.cover,
                            ),
                          ),
                          onTap: () async {
                            await Navigator.of(context).pushNamed(
                              Rotas.menu,
                              arguments: {'menu': 1, 'sacola': state.sacola},
                            );
                          },
                        ),
                        CustomRectangle(
                          width: 120,
                          height: 120,
                          child: CustomStackHome(
                            labelText: 'Sushi',
                            image: Image.asset(
                              ImageConstants.sushi,
                              fit: BoxFit.cover,
                            ),
                          ),
                          onTap: () async {
                            await Navigator.of(context).pushNamed(
                              Rotas.menu,
                              arguments: {'menu': 4, 'sacola': state.sacola},
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                Padding(
                  padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                  child: SizedBox(
                    width: context.percentWidth(1),
                    height: 120,
                    child: Wrap(
                      spacing: 8,
                      alignment: WrapAlignment.spaceAround,
                      children: [
                        CustomRectangle(
                          width: 120,
                          height: 120,
                          child: CustomStackHome(
                            labelText: 'Refrigerantes',
                            image: Image.asset(
                              ImageConstants.refri,
                              fit: BoxFit.cover,
                            ),
                          ),
                          onTap: () async {
                            await Navigator.of(context).pushNamed(
                              Rotas.menu,
                              arguments: {'menu': 5, 'sacola': state.sacola},
                            );
                          },
                        ),
                        CustomRectangle(
                          width: 120,
                          height: 120,
                          child: CustomStackHome(
                            labelText: 'Hamburguer',
                            image: Image.asset(
                              ImageConstants.hamburguer,
                              fit: BoxFit.cover,
                            ),
                          ),
                          onTap: () async {
                            await Navigator.of(context).pushNamed(
                              Rotas.menu,
                              arguments: {'menu': 6, 'sacola': state.sacola},
                            );
                          },
                        ),
                        CustomRectangle(
                          width: 120,
                          height: 120,
                          child: CustomStackHome(
                            labelText: 'Pizzas',
                            image: Image.asset(
                              ImageConstants.pizza,
                              fit: BoxFit.cover,
                            ),
                          ),
                          onTap: () async {
                            await Navigator.of(context).pushNamed(
                              Rotas.menu,
                              arguments: {'menu': 3, 'sacola': state.sacola},
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                Container(
                  padding: EdgeInsets.all(8),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Promoções do dia.",
                    style: context.cusotomFontes.textExtraBold.copyWith(
                      fontSize: 20,
                      color: ColorsConstants.buttonColor,
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    height: context.percentHeight(0.38),
                    child: ListView.builder(
                      itemCount: promocoesGerais!.length,
                      itemBuilder: (context, index) {
                        PromocoesModelResponse promocaoGeral =
                            promocoesGerais[index];
                        return Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomItem(
                                heightImage: 50,
                                widthImage: 50,
                                childImage: Image.network(
                                  promocaoGeral.produtoImage,
                                  fit: BoxFit.cover,
                                ),
                                children: [
                                  CustomCampoItem(
                                    labelText: promocaoGeral.produtoNome,
                                    paddingText: EdgeInsets.only(
                                      top: 5,
                                      left: 8,
                                      right: 8,
                                    ),
                                  ),
                                  CustomCampoItem(
                                    labelText: promocaoGeral.produtoDescricao,
                                    paddingText: EdgeInsets.only(
                                      top: 5,
                                      left: 8,
                                      right: 8,
                                    ),
                                    widthText: context.percentWidth(0.5),
                                    style: context.cusotomFontes.textBold
                                        .copyWith(
                                          fontSize: 13,
                                          color: brightness == Brightness.light
                                              ? ColorsConstants.letrasColor
                                              : ColorsConstants.primaryColor,
                                          height: 1,
                                        ),
                                  ),
                                  Row(
                                    children: [
                                      CustomCampoItem(
                                        labelText:
                                            'R\$${promocaoGeral.precoVariacao}',
                                        style: context.cusotomFontes.textBold
                                            .copyWith(
                                              fontSize: 13,
                                              color:
                                                  brightness == Brightness.light
                                                  ? ColorsConstants.letrasColor
                                                  : ColorsConstants
                                                        .primaryColor,
                                              height: 1,
                                              decoration:
                                                  TextDecoration.lineThrough,
                                            ),
                                        paddingText: EdgeInsets.only(
                                          top: 5,
                                          left: 8,
                                          right: 8,
                                        ),
                                        widthText: 70,
                                      ),
                                      CustomCampoItem(
                                        labelText:
                                            'R\$${promocaoGeral.precoPromocao}',
                                        style: context.cusotomFontes.textBold
                                            .copyWith(
                                              fontSize: 13,
                                              color:
                                                  brightness == Brightness.light
                                                  ? ColorsConstants.letrasColor
                                                  : ColorsConstants
                                                        .primaryColor,
                                              height: 1,
                                            ),
                                        paddingText: EdgeInsets.only(
                                          top: 5,
                                          left: 8,
                                          right: 8,
                                        ),
                                        widthText: 70,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              CustomButtonsAddRemove(
                                childAdd: Image.asset(
                                  ImageConstants.addGeral,
                                  width: 23,
                                  height: 23,
                                  fit: BoxFit.cover,
                                ),
                                onTapAdd: () {
                                  ProdutoModel produto = ProdutoModel(
                                    produtoId: promocaoGeral.produtoId,
                                    promocaoId: promocaoGeral.promocaoId,
                                    preco: promocaoGeral.precoPromocao
                                        .toDouble(),
                                    produtoNome: promocaoGeral.produtoNome,
                                  );
                                  controller.adicionaProdutoSacola(
                                    produto,
                                    index,
                                  );
                                },
                                onTapRemove: () {
                                  ProdutoModel produto = ProdutoModel(
                                    produtoId: promocaoGeral.produtoId,
                                    promocaoId: promocaoGeral.promocaoId,
                                    preco: promocaoGeral.precoPromocao
                                        .toDouble(),
                                    produtoNome: promocaoGeral.produtoNome,
                                  );
                                  controller.removeProdutoSacola(
                                    produto,
                                    index,
                                  );
                                },
                                labelCount: state.sacola
                                    ?.firstWhere(
                                      (item) =>
                                          item.produtoModel!.produtoId ==
                                          promocaoGeral.produtoId,
                                      orElse: () => SacolaModelRequest(
                                        cont: 0,
                                        produtoModel: null,
                                      ),
                                    )
                                    .cont
                                    .toString(),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                if (state.sacola!.isNotEmpty)
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 8,
                        right: 8,
                        bottom: 15,
                      ),
                      child: CustomButtomCarrinho(
                        total: state.sacola
                            ?.fold(
                              0.0,
                              (total, item) => total + item.totalPreco,
                            )
                            .toStringAsFixed(2),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
