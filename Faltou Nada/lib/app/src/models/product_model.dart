// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ProductModel {
  int id;
  String nome;
  String foto;
  ProductModel({
    this.id = 0,
    this.nome = '',
    this.foto = '',
  });

  ProductModel copyWith({
    int? id,
    String? nome,
    String? foto,
  }) {
    return ProductModel(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      foto: foto ?? this.foto,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nome': nome,
      'foto': foto,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] ?? 0,
      nome: map['nome'] ?? '',
      foto: map['foto'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ProductModel(id: $id, nome: $nome, foto: $foto)';

  @override
  bool operator ==(covariant ProductModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.nome == nome && other.foto == foto;
  }

  @override
  int get hashCode => id.hashCode ^ nome.hashCode ^ foto.hashCode;
}
