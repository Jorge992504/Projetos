// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PromocoesModelResponse {
  int produtoId;
  String produtoImage;
  String produtoNome;
  String produtoAdicionalNome;
  num produtoQuantidade;
  String produtoDescricao;
  String produtoAdicionalDescricaoQtde;
  num produtoAdicionalQuantidade;
  String produtoDescricaoQtde;
  int promocaoId;
  int produtoAdicionalId;
  num precoPromocao;
  num precoVariacao;
  PromocoesModelResponse({
    required this.produtoId,
    required this.produtoImage,
    required this.produtoNome,
    required this.produtoAdicionalNome,
    required this.produtoQuantidade,
    required this.produtoDescricao,
    required this.produtoAdicionalDescricaoQtde,
    required this.produtoAdicionalQuantidade,
    required this.produtoDescricaoQtde,
    required this.promocaoId,
    required this.produtoAdicionalId,
    required this.precoPromocao,
    required this.precoVariacao,
  });

  PromocoesModelResponse copyWith({
    int? produtoId,
    String? produtoImage,
    String? produtoNome,
    String? produtoAdicionalNome,
    num? produtoQuantidade,
    String? produtoDescricao,
    String? produtoAdicionalDescricaoQtde,
    num? produtoAdicionalQuantidade,
    String? produtoDescricaoQtde,
    int? promocaoId,
    int? produtoAdicionalId,
    num? precoPromocao,
    num? precoVariacao,
  }) {
    return PromocoesModelResponse(
      produtoId: produtoId ?? this.produtoId,
      produtoImage: produtoImage ?? this.produtoImage,
      produtoNome: produtoNome ?? this.produtoNome,
      produtoAdicionalNome: produtoAdicionalNome ?? this.produtoAdicionalNome,
      produtoQuantidade: produtoQuantidade ?? this.produtoQuantidade,
      produtoDescricao: produtoDescricao ?? this.produtoDescricao,
      produtoAdicionalDescricaoQtde:
          produtoAdicionalDescricaoQtde ?? this.produtoAdicionalDescricaoQtde,
      produtoAdicionalQuantidade:
          produtoAdicionalQuantidade ?? this.produtoAdicionalQuantidade,
      produtoDescricaoQtde: produtoDescricaoQtde ?? this.produtoDescricaoQtde,
      promocaoId: promocaoId ?? this.promocaoId,
      produtoAdicionalId: produtoAdicionalId ?? this.produtoAdicionalId,
      precoPromocao: precoPromocao ?? this.precoPromocao,
      precoVariacao: precoVariacao ?? this.precoVariacao,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'produtoId': produtoId,
      'produtoImage': produtoImage,
      'produtoNome': produtoNome,
      'produtoAdicionalNome': produtoAdicionalNome,
      'produtoQuantidade': produtoQuantidade,
      'produtoDescricao': produtoDescricao,
      'produtoAdicionalDescricaoQtde': produtoAdicionalDescricaoQtde,
      'produtoAdicionalQuantidade': produtoAdicionalQuantidade,
      'produtoDescricaoQtde': produtoDescricaoQtde,
      'promocaoId': promocaoId,
      'produtoAdicionalId': produtoAdicionalId,
      'precoPromocao': precoPromocao,
      'precoVariacao': precoVariacao,
    };
  }

  factory PromocoesModelResponse.fromMap(Map<String, dynamic> map) {
    return PromocoesModelResponse(
      produtoId: map['produtoId'] ?? 0,
      produtoImage: map['produtoImage'] ?? "",
      produtoNome: map['produtoNome'] ?? "",
      produtoAdicionalNome: map['produtoAdicionalNome'] ?? "",
      produtoQuantidade: map['produtoQuantidade'] ?? 0.0,
      produtoDescricao: map['produtoDescricao'] ?? "",
      produtoAdicionalDescricaoQtde: map['produtoAdicionalDescricaoQtde'] ?? "",
      produtoAdicionalQuantidade: map['produtoAdicionalQuantidade'] ?? 0.0,
      produtoDescricaoQtde: map['produtoDescricaoQtde'] ?? "",
      promocaoId: map['promocaoId'] ?? 0,
      produtoAdicionalId: map['produtoAdicionalId'] ?? 0,
      precoPromocao: map['precoPromocao'] ?? 0.0,
      precoVariacao: map['precoVariacao'] ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory PromocoesModelResponse.fromJson(String source) =>
      PromocoesModelResponse.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  @override
  String toString() {
    return 'PromocoesModelResponse(produtoId: $produtoId, produtoImage: $produtoImage, produtoNome: $produtoNome, produtoAdicionalNome: $produtoAdicionalNome, produtoQuantidade: $produtoQuantidade, produtoDescricao: $produtoDescricao, produtoAdicionalDescricaoQtde: $produtoAdicionalDescricaoQtde, produtoAdicionalQuantidade: $produtoAdicionalQuantidade, produtoDescricaoQtde: $produtoDescricaoQtde, promocaoId: $promocaoId, produtoAdicionalId: $produtoAdicionalId, precoPromocao: $precoPromocao, precoVariacao: $precoVariacao)';
  }

  @override
  bool operator ==(covariant PromocoesModelResponse other) {
    if (identical(this, other)) return true;

    return other.produtoId == produtoId &&
        other.produtoImage == produtoImage &&
        other.produtoNome == produtoNome &&
        other.produtoAdicionalNome == produtoAdicionalNome &&
        other.produtoQuantidade == produtoQuantidade &&
        other.produtoDescricao == produtoDescricao &&
        other.produtoAdicionalDescricaoQtde == produtoAdicionalDescricaoQtde &&
        other.produtoAdicionalQuantidade == produtoAdicionalQuantidade &&
        other.produtoDescricaoQtde == produtoDescricaoQtde &&
        other.promocaoId == promocaoId &&
        other.produtoAdicionalId == produtoAdicionalId &&
        other.precoPromocao == precoPromocao &&
        other.precoVariacao == precoVariacao;
  }

  @override
  int get hashCode {
    return produtoId.hashCode ^
        produtoImage.hashCode ^
        produtoNome.hashCode ^
        produtoAdicionalNome.hashCode ^
        produtoQuantidade.hashCode ^
        produtoDescricao.hashCode ^
        produtoAdicionalDescricaoQtde.hashCode ^
        produtoAdicionalQuantidade.hashCode ^
        produtoDescricaoQtde.hashCode ^
        promocaoId.hashCode ^
        produtoAdicionalId.hashCode ^
        precoPromocao.hashCode ^
        precoVariacao.hashCode;
  }
}
