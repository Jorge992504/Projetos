//import 'dart:js';

import 'package:delivery/app/pages/product_detail/product_detail.dart';
import 'package:delivery/app/pages/product_detail/product_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailRouter {
  ProductDetailRouter._();

  static Widget get page => MultiProvider(
          providers: [
            Provider(create: (context) => ControlarProdutos()),
          ],
          builder: (context, child) {
            final args = ModalRoute.of(context)!.settings.arguments
                as Map<String, dynamic>;
            return ProductDetailPage(
              product: args['product'],
              order: args['order'],
            );
          });
}
