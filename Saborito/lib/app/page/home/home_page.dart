import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saborito/app/core/ui/base_state/base_state.dart';

import 'package:saborito/app/core/ui/widgets/saboritos_app_bar.dart';

import 'package:saborito/app/page/home/home_controller.dart';
import 'package:saborito/app/page/home/home_state.dart';
import 'package:saborito/app/page/home/widgets/sbt_produto_tile.dart';

// showLoader();                                 menssages de na tela
// await Future.delayed(Duration(seconds: 2));
// showLoader();
// showError('error');
//--------------------------------------------------------
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends BaseState<HomePage, HomeController> {
  @override
  void onReady() {
    controller.laodedProdutos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SaboritosAppBar(),
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
              Expanded(
                child: ListView.builder(
                  itemCount: state.produtos.length,
                  itemBuilder: (context, index) {
                    final produtos = state.produtos[index];
                    final orders = state.shoppingBag
                        .where((order) => order.produtos == produtos);
                    return SbtProdutoTile(
                      produto: produtos,
                      orderProduto: orders.isNotEmpty ? orders.first : null,
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
