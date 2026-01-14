// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CategoriasModel {
  int? id;
  String? nome;
  CategoriasModel({this.id, this.nome});

  CategoriasModel copyWith({int? id, String? nome}) {
    return CategoriasModel(id: id ?? this.id, nome: nome ?? this.nome);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'id': id, 'nome': nome};
  }

  factory CategoriasModel.fromMap(Map<String, dynamic> map) {
    return CategoriasModel(
      id: map['id'] != null ? map['id'] as int : null,
      nome: map['nome'] != null ? map['nome'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoriasModel.fromJson(String source) =>
      CategoriasModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CategoriasModel(id: $id, nome: $nome)';

  @override
  bool operator ==(covariant CategoriasModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.nome == nome;
  }

  @override
  int get hashCode => id.hashCode ^ nome.hashCode;
}
