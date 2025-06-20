// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Ses1184iItemModel {
  int filial;
  int produto;
  int clifor;
  int motivo;
  String obs;
  num qtProduto;
  Ses1184iItemModel({
    this.filial = 0,
    this.produto = 0,
    this.clifor = 0,
    this.motivo = 0,
    this.obs = '',
    this.qtProduto = 0,
  });

  Ses1184iItemModel copyWith({
    int? filial,
    int? produto,
    int? clifor,
    int? motivo,
    String? obs,
    num? qtProduto,
  }) {
    return Ses1184iItemModel(
      filial: filial ?? this.filial,
      produto: produto ?? this.produto,
      clifor: clifor ?? this.clifor,
      motivo: motivo ?? this.motivo,
      obs: obs ?? this.obs,
      qtProduto: qtProduto ?? this.qtProduto,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'filial': filial,
      'produto': produto,
      'clifor': clifor,
      'motivo': motivo,
      'obs': obs,
      'qtProduto': qtProduto,
    };
  }

  factory Ses1184iItemModel.fromMap(Map<String, dynamic> map) {
    return Ses1184iItemModel(
      filial: map['filial'] ?? 0,
      produto: map['produto'] ?? 0,
      clifor: map['clifor'] ?? 0,
      motivo: map['motivo'] ?? 0,
      obs: map['obs'] ?? '',
      qtProduto: map['qtProduto'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Ses1184iItemModel.fromJson(String source) =>
      Ses1184iItemModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Ses1184iItemModel(filial: $filial, produto: $produto, clifor: $clifor, motivo: $motivo, obs: $obs, qtProduto: $qtProduto)';
  }

  @override
  bool operator ==(covariant Ses1184iItemModel other) {
    if (identical(this, other)) return true;

    return other.filial == filial &&
        other.produto == produto &&
        other.clifor == clifor &&
        other.motivo == motivo &&
        other.obs == obs &&
        other.qtProduto == qtProduto;
  }

  @override
  int get hashCode {
    return filial.hashCode ^
        produto.hashCode ^
        clifor.hashCode ^
        motivo.hashCode ^
        obs.hashCode ^
        qtProduto.hashCode;
  }
}
