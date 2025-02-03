import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saborito/app/page/produto_detail/produto_detail_controller.dart';
import 'package:saborito/app/page/produto_detail/produto_detail_page.dart';

class ProdutoDetailRouter {
  ProdutoDetailRouter._();
  static Widget get page => MultiProvider(
        providers: [
          Provider(
            create: (context) => ProdutoDetailController(),
          ),
        ],
        builder: (context, child) {
          final args = ModalRoute.of(context)!.settings.arguments
              as Map<String, dynamic>;
          return ProdutoDetailPage(
            produto: args['produto'],
            order: args['order'],
          );
        },
      );
}
