import 'dart:convert';

class ModeloTreino {
  late int id;

  late String nome;
  ModeloTreino({
    required this.nome,
    required this.id,
  });

  ModeloTreino.fromModeloTreino() {
    nome = "";

    id = 0;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
    };
  }

  factory ModeloTreino.fromMap(Map<String, dynamic> map) {
    return ModeloTreino(
      id: map['id']?.toInt() ?? 0,
      nome: map['nome']?.toString() ?? '',
    );
  }
  String toJson() => json.encode(toMap());
  factory ModeloTreino.fromJson(String source) =>
      ModeloTreino.fromMap(json.decode(source));
}
