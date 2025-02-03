// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:saborito/app/models/produto_model.dart';

class OrderProdutoDto {
  final ProdutoModel produtos;
  final int amount;
  OrderProdutoDto({
    required this.produtos,
    required this.amount,
  });

  double get totalPrice => amount * produtos.preco;
}
