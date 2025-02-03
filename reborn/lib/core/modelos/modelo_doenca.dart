import 'dart:convert';

class ModeloDoenca {
  late String nome;
  late int id;

  ModeloDoenca({
    required this.nome,
    required this.id,
  });

  ModeloDoenca.fromModeloDoenca() {
    nome = "";
    id = 0;
  }

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'id': id,
    };
  }

  factory ModeloDoenca.fromMap(Map<String, dynamic> map) {
    return ModeloDoenca(
      nome: map['nome']?.toString() ?? '',
      id: map['id']?.toInt() ?? 0,
    );
  }
  String toJson() => json.encode(toMap());
  factory ModeloDoenca.fromJson(String source) =>
      ModeloDoenca.fromMap(json.decode(source));
}
