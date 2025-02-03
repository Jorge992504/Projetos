import 'package:delivery/app/core/ui/base_state/base_state.dart';
//import 'package:delivery/app/core/ui/helpers/louder.dart';
//import 'package:delivery/app/core/ui/helpers/messages.dart';
import 'package:delivery/app/core/ui/widgets/delivery_appbar.dart';
//import 'package:delivery/app/models/prod_mod.dart';
import 'package:delivery/app/pages/home/delivery_product_tile.dart';
import 'package:delivery/app/pages/home/home_controller.dart';
import 'package:delivery/app/pages/home/home_state.dart';
import 'package:delivery/app/pages/home/shopping_bag.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:match/match.dart';
//import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends BaseState<HomePage, HomeController> {
  @override
  void onReady() {
    controller.loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DeliveryAppbar(),
      // floatingActionButton: FloatingActionButton(
      //   // botão flotante da esquina direita
      //   onPressed: () async {
      //     //showLoader();
      //     //await Future.delayed(Duration(seconds: 2));
      //     //hideLoader();
      //     //carrega as mensages de status na tela
      //     //showError('Erro ao carregar');
      //     //await Future.delayed(Duration(seconds: 2));
      //     //showInfo('Info ao carregar');
      //     //await Future.delayed(Duration(seconds: 2));
      //     //showSuccess('Sucesso ao carregar');
      //     Navigator.of(context).popAndPushNamed('/'); //provisorio
      //   },
      // ),
      body: BlocConsumer<HomeController, HomeState>(
        listener: (context, state) {
          state.status.matchAny(
            any: () => hideLoader(),
            loading: () => showLoader(),
            error: () {
              hideLoader();
              showError(state.errorMessage ?? 'Erro não informado');
            },
          );
        },
        buildWhen: (previous, current) => current.status.matchAny(
          any: () => false,
          initial: () => true,
          loaded: () => true,
        ),
        builder: (context, state) {
          return Column(
            children: [
              //Text(state.shoppingBag.length.toString()),//cria um text na tela e pega a quantidade de vezes q o usuario click no botao adicionar
              Expanded(
                //faz o lsitview entrar no column
                child: ListView.builder(
                  itemCount: state.products.length, //pega os itens do BD
                  itemBuilder: (context, index) {
                    final product = state.products[index];
                    final orders = state.shoppingBag
                        .where((order) => order.product == product);
                    return DeliveryProductTile(
                      product: product,
                      retorno2: orders.isNotEmpty
                          ? orders.first
                          : null, //retorna nada se nao tiver nada na sacola
                    ); //retorna o nome dos produtos
                  },
                ),
              ),
              Visibility(
                visible: state.shoppingBag.isNotEmpty,
                child: ShoppingBag(bag: state.shoppingBag),
              ),
            ],
          );
        },
      ),

      //AppBar(
      //title: const Text('Home Page'),
      //),
      //body: Container(
      //child: Text('HomePage'),
      //child: Center(
      //child: ElevatedButton(
      //child: Text('Voltar'),
      //onPressed: () {
      //Navigator.of(context).popAndPushNamed('/');
      //}),
      //)),
    );
  }
}
