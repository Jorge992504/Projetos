import 'package:saborito/app/models/produto_model.dart';

abstract class ProdutosRepository {
  Future<List<ProdutoModel>> listarProdutos();
}
