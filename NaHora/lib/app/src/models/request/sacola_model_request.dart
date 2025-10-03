// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:nahora/app/src/models/produto_model.dart';

class SacolaModelRequest {
  ProdutoModel? produtoModel;
  int? cont;
  SacolaModelRequest({this.produtoModel, this.cont});

  double get totalPreco => cont! * (produtoModel?.preco ?? 0.0);

  SacolaModelRequest copyWith({ProdutoModel? produtoModel, int? cont}) {
    return SacolaModelRequest(
      produtoModel: produtoModel ?? this.produtoModel,
      cont: cont ?? this.cont,
    );
  }
}
