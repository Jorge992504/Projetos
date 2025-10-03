// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ProdutoModel {
  int? produtoId;
  int? promocaoId;
  String? produtoNome;
  double? preco;
  ProdutoModel({this.produtoId, this.promocaoId, this.produtoNome, this.preco});

  ProdutoModel copyWith({
    int? produtoId,
    int? promocaoId,
    String? produtoNome,
    double? preco,
  }) {
    return ProdutoModel(
      produtoId: produtoId ?? this.produtoId,
      promocaoId: promocaoId ?? this.promocaoId,
      produtoNome: produtoNome ?? this.produtoNome,
      preco: preco ?? this.preco,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'produtoId': produtoId,
      'promocaoId': promocaoId,
      'produtoNome': produtoNome,
      'preco': preco,
    };
  }

  factory ProdutoModel.fromMap(Map<String, dynamic> map) {
    return ProdutoModel(
      produtoId: map['produtoId'] ?? 0,
      promocaoId: map['promocaoId'] ?? 0,
      produtoNome: map['produtoNome'] ?? '',
      preco: map['preco'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProdutoModel.fromJson(String source) =>
      ProdutoModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProdutoModel(produtoId: $produtoId, promocaoId: $promocaoId, produtoNome: $produtoNome, preco: $preco)';
  }

  @override
  bool operator ==(covariant ProdutoModel other) {
    if (identical(this, other)) return true;

    return other.produtoId == produtoId &&
        other.promocaoId == promocaoId &&
        other.produtoNome == produtoNome &&
        other.preco == preco;
  }

  @override
  int get hashCode {
    return produtoId.hashCode ^
        promocaoId.hashCode ^
        produtoNome.hashCode ^
        preco.hashCode;
  }
}
