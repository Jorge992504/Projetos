// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ListaRelatoriosModel {
  int? id;
  String? descricao;
  ListaRelatoriosModel({this.id, this.descricao});

  ListaRelatoriosModel copyWith({int? id, String? descricao}) {
    return ListaRelatoriosModel(
      id: id ?? this.id,
      descricao: descricao ?? this.descricao,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'id': id, 'descricao': descricao};
  }

  factory ListaRelatoriosModel.fromMap(Map<String, dynamic> map) {
    return ListaRelatoriosModel(
      id: map['id'] ?? 0,
      descricao: map['descricao'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ListaRelatoriosModel.fromJson(String source) =>
      ListaRelatoriosModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ListaRelatoriosModel(id: $id, descricao: $descricao)';

  @override
  bool operator ==(covariant ListaRelatoriosModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.descricao == descricao;
  }

  @override
  int get hashCode => id.hashCode ^ descricao.hashCode;
}
