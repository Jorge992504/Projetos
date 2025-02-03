// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:delivery/app/core/extensions/formater_extension.dart';

import 'package:delivery/app/core/ui/style/text_styles.dart';
import 'package:delivery/app/pages/home/home_controller.dart';
import 'package:delivery/app/pages/order/widgets/order_produto_tile.dart';
import 'package:flutter/material.dart';

import 'package:delivery/app/core/ui/helpers/size_extensions.dart';
import 'package:delivery/app/dto/ordem_produto_dto.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShoppingBag extends StatelessWidget {
  final List<OrdemProduto> bag;
  const ShoppingBag({super.key, required this.bag});
  Future<void> _goOrder(BuildContext context) async {
    final navigator = Navigator.of(context);
    final controller = context.read<HomeController>();
    final sp = await SharedPreferences.getInstance();
    if (!sp.containsKey('token')) {
      final loginResult = await navigator.pushNamed('/auth/login');
      if (loginResult == null || loginResult == false) {
        return;
      }
    }
    final updateBag = await navigator.pushNamed('/order', arguments: bag);
    controller.UpdateBag(updateBag as List<OrdemProduto>);
  }

  @override
  Widget build(BuildContext context) {
    var totalBag = bag
        .fold<double>(0.0, (total, element) => total += element.totalPreco)
        .currencyPTBR;
    return Container(
      width: context.screenWidth,
      height: 68,
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 5,
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(17),
          topRight: Radius.circular(17),
        ),
      ),
      child: ElevatedButton(
        onPressed: () {
          _goOrder(context);
        },
        child: Stack(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Icon(
                Icons.shopping_cart_outlined,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Ver sacola',
                style: context.textStyles.textExtraBold.copyWith(fontSize: 14),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                totalBag,
                style: context.textStyles.textExtraBold.copyWith(fontSize: 11),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
