import 'dart:convert';

class ProdutoModel {
  final int id;
  final String nome;
  final String descricao;
  final double preco;
  final String foto;
  ProdutoModel({
    required this.id,
    required this.nome,
    required this.descricao,
    required this.preco,
    required this.foto,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'descricao': descricao,
      'preco': preco,
      'foto': foto,
    };
  }

  factory ProdutoModel.fromMap(Map<String, dynamic> map) {
    return ProdutoModel(
      id: map['id'] as int,
      nome: map['nome'] as String,
      descricao: map['descricao'] as String,
      preco: double.parse(map['preco']),
      foto: map['foto'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProdutoModel.fromJson(String source) =>
      ProdutoModel.fromMap(json.decode(source));
}
