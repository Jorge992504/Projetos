// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:delivery/app/models/prod_mod.dart';

class OrdemProduto {
  final ProdMod product;
  final int cont;

  OrdemProduto({
    required this.product,
    required this.cont,
  });

  double get totalPreco => cont * product.price;
}
