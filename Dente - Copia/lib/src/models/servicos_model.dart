// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ServicosModel {
  String? nome;
  num? vl;
  ServicosModel({this.nome, this.vl});

  ServicosModel copyWith({String? nome, num? vl}) {
    return ServicosModel(nome: nome ?? this.nome, vl: vl ?? this.vl);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'nome': nome, 'vl': vl};
  }

  factory ServicosModel.fromMap(Map<String, dynamic> map) {
    return ServicosModel(nome: map['nome'] ?? "", vl: map['vl'] ?? 0);
  }

  String toJson() => json.encode(toMap());

  factory ServicosModel.fromJson(String source) =>
      ServicosModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ServicosModel(nome: $nome, vl: $vl)';

  @override
  bool operator ==(covariant ServicosModel other) {
    if (identical(this, other)) return true;

    return other.nome == nome && other.vl == vl;
  }

  @override
  int get hashCode => nome.hashCode ^ vl.hashCode;
}
