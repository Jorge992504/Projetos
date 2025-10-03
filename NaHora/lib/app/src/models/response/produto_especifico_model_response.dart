// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ProdutoEspecificoModelResponse {
  int? produtoId;
  String? produtoImage;
  String? produtoNome;
  num? produtoQuantidade;
  String? produtoDescricao;
  String? produtoDescricaoQtde;
  num? precoVariacao;
  ProdutoEspecificoModelResponse({
    this.produtoId,
    this.produtoImage,
    this.produtoNome,
    this.produtoQuantidade,
    this.produtoDescricao,
    this.produtoDescricaoQtde,
    this.precoVariacao,
  });

  ProdutoEspecificoModelResponse copyWith({
    int? produtoId,
    String? produtoImage,
    String? produtoNome,
    num? produtoQuantidade,
    String? produtoDescricao,
    String? produtoDescricaoQtde,
    num? precoVariacao,
  }) {
    return ProdutoEspecificoModelResponse(
      produtoId: produtoId ?? this.produtoId,
      produtoImage: produtoImage ?? this.produtoImage,
      produtoNome: produtoNome ?? this.produtoNome,
      produtoQuantidade: produtoQuantidade ?? this.produtoQuantidade,
      produtoDescricao: produtoDescricao ?? this.produtoDescricao,
      produtoDescricaoQtde: produtoDescricaoQtde ?? this.produtoDescricaoQtde,
      precoVariacao: precoVariacao ?? this.precoVariacao,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'produtoId': produtoId,
      'produtoImage': produtoImage,
      'produtoNome': produtoNome,
      'produtoQuantidade': produtoQuantidade,
      'produtoDescricao': produtoDescricao,
      'produtoDescricaoQtde': produtoDescricaoQtde,
      'precoVariacao': precoVariacao,
    };
  }

  factory ProdutoEspecificoModelResponse.fromMap(Map<String, dynamic> map) {
    return ProdutoEspecificoModelResponse(
      produtoId: map['produtoId'] ?? 0,
      produtoImage: map['produtoImage'] ?? '',
      produtoNome: map['produtoNome'] ?? '',
      produtoQuantidade: map['produtoQuantidade'] ?? 0,
      produtoDescricao: map['produtoDescricao'] ?? '',
      produtoDescricaoQtde: map['produtoDescricaoQtde'] ?? '',
      precoVariacao: map['precoVariacao'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProdutoEspecificoModelResponse.fromJson(String source) =>
      ProdutoEspecificoModelResponse.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  @override
  String toString() {
    return 'ProdutoEspecificoModelResponse(produtoId: $produtoId, produtoImage: $produtoImage, produtoNome: $produtoNome, produtoQuantidade: $produtoQuantidade, produtoDescricao: $produtoDescricao, produtoDescricaoQtde: $produtoDescricaoQtde, precoVariacao: $precoVariacao)';
  }

  @override
  bool operator ==(covariant ProdutoEspecificoModelResponse other) {
    if (identical(this, other)) return true;

    return other.produtoId == produtoId &&
        other.produtoImage == produtoImage &&
        other.produtoNome == produtoNome &&
        other.produtoQuantidade == produtoQuantidade &&
        other.produtoDescricao == produtoDescricao &&
        other.produtoDescricaoQtde == produtoDescricaoQtde &&
        other.precoVariacao == precoVariacao;
  }

  @override
  int get hashCode {
    return produtoId.hashCode ^
        produtoImage.hashCode ^
        produtoNome.hashCode ^
        produtoQuantidade.hashCode ^
        produtoDescricao.hashCode ^
        produtoDescricaoQtde.hashCode ^
        precoVariacao.hashCode;
  }
}
