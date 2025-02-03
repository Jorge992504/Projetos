import 'package:delivery/app/core/extensions/formater_extension.dart';
import 'package:delivery/app/core/ui/base_state/base_state.dart';
import 'package:delivery/app/core/ui/style/text_styles.dart';
import 'package:delivery/app/core/ui/widgets/delivery_appbar.dart';
import 'package:delivery/app/core/ui/widgets/delivery_button.dart';
import 'package:delivery/app/dto/ordem_produto_dto.dart';

import 'package:delivery/app/models/payment_types_model.dart';

import 'package:delivery/app/pages/order/order_controller.dart';
import 'package:delivery/app/pages/order/order_state.dart';
import 'package:delivery/app/pages/order/widgets/order-field.dart';
import 'package:delivery/app/pages/order/widgets/order_produto_tile.dart';
import 'package:delivery/app/pages/order/widgets/payment_types_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validatorless/validatorless.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends BaseState<OrderPage, OrderController> {
  final formKey = GlobalKey<FormState>();
  final endereco = TextEditingController();
  final cpf = TextEditingController();
  int? pyamentTypeId;
  final paymentTypeValid = ValueNotifier<bool>(true);
  @override
  void onReady() {
    final produtos =
        ModalRoute.of(context)!.settings.arguments as List<OrdemProduto>;
    controller.load(produtos);
  }

  void _showConfirmProdutoDialog(OrderConfirmDeleteProdutoState state) {
    showDialog(
      context: context,
      barrierDismissible: false, //para q o usuario tenha q escolher uma opcao
      builder: (context) {
        return AlertDialog(
          title: Text(
              'Deseja excluir o produto ${state.ordemProduto.product.name}?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                controller.cancelDeleteProduto();
              },
              child: Text(
                'Cancelar',
                style: context.textStyles.textBold.copyWith(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                controller.decrementarProduto(state.index);
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
    return BlocListener<OrderController, OrderState>(
      listener: (context, state) {
        state.status.matchAny(
            any: () => hideLoader(),
            loading: () => showLoader(),
            error: () {
              hideLoader();
              showError(state.errorMEssage ?? 'Erro não informado');
            },
            confirmRemoveProduto: () {
              hideLoader();
              if (state is OrderConfirmDeleteProdutoState) {
                _showConfirmProdutoDialog(state);
              }
            },
            emptyBag: () {
              showInfo(
                  'Sua sacola esta vazia, por favor selecione um produto para realizar seu pedido');
              Navigator.pop(context, <OrdemProduto>[]);
            },
            success: () {
              hideLoader();
              Navigator.of(context).popAndPushNamed('/order/completed',
                  result: <OrdemProduto>[]);
            });
      },
      child: WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop(controller.state.orderProdutos);
          return false;
        },
        child: Scaffold(
          appBar: DeliveryAppbar(),
          body: Form(
            key: formKey,
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Row(
                      children: [
                        Text(
                          'Carrinho',
                          style: context.textStyles.textTitle,
                        ),
                        IconButton(
                          onPressed: () {
                            controller.emptyBag();
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                BlocSelector<OrderController, OrderState, List<OrdemProduto>>(
                  selector: (state) => state.orderProdutos,
                  builder: (context, orderProdutos) {
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        childCount: orderProdutos.length,
                        (context, index) {
                          final orderProduto = orderProdutos[index];
                          return Column(
                            children: [
                              OrderProdutoTile(
                                index: index,
                                orderProdutoDto: orderProduto,
                              ),
                              Divider(
                                color: Colors.grey[350],
                              ),
                            ],
                          );
                        },
                      ),
                    );
                  },
                ),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Preço',
                              style: context.textStyles.textExtraBold
                                  .copyWith(fontSize: 16),
                            ),
                            BlocSelector<OrderController, OrderState, double>(
                              selector: (state) => state.totalOrder,
                              builder: (context, totalOrder) {
                                return Text(
                                  totalOrder.currencyPTBR,
                                  style: context.textStyles.textExtraBold
                                      .copyWith(fontSize: 20),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.grey[305],
                      ),
                      // const SizedBox(
                      //   height: 5,
                      // ),
                      OrderField(
                        title: 'Endereço de entrega',
                        controller: endereco,
                        validator:
                            Validatorless.required('Endereço obrigatorio'),
                        hintText: 'Digite o endereço',
                      ),
                      // const SizedBox(
                      //   height: 5,
                      // ),
                      OrderField(
                        title: 'CPF',
                        controller: cpf,
                        validator: Validatorless.required('CPF obrigatorio'),
                        hintText: 'Digite o CPF',
                      ),
                      BlocSelector<OrderController, OrderState,
                          List<PaymentTypesModel>>(
                        selector: (state) => state.paymentTypes,
                        builder: (context, paymentTypes) {
                          return ValueListenableBuilder(
                            valueListenable: paymentTypeValid,
                            builder: (_, paymentTypeValidValue, child) {
                              return PaymentTypesField(
                                title: 'Formas de pagamentos',
                                paymentTypes: paymentTypes,
                                valueChanged: (value) {
                                  pyamentTypeId = value;
                                },
                                valid: paymentTypeValidValue,
                                valueSelect: pyamentTypeId.toString(),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Divider(color: Colors.grey[305]),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: DeliveryButton(
                          width: double.infinity,
                          height: 48,
                          label: 'Finalizar',
                          onPressed: () {
                            final valid =
                                formKey.currentState?.validate() ?? false;
                            final paymentTypeSelect = pyamentTypeId != null;
                            paymentTypeValid.value = paymentTypeSelect;

                            if (valid && paymentTypeSelect) {
                              controller.saveOrder(
                                address: endereco.text,
                                document: cpf.text,
                                paymentMethodId: pyamentTypeId!,
                              );
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
