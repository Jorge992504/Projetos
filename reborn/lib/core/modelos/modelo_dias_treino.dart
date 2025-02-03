import 'dart:convert';

class ModeloDiasTreino {
  late String nome;
  late int id;

  ModeloDiasTreino({
    required this.nome,
    required this.id,
  });

  ModeloDiasTreino.fromModeloDiasTreino() {
    nome = "";
    id = 0;
  }

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'id': id,
    };
  }

  factory ModeloDiasTreino.fromMap(Map<String, dynamic> map) {
    return ModeloDiasTreino(
      nome: map['nome']?.toString() ?? '',
      id: map['id']?.toInt() ?? 0,
    );
  }
  String toJson() => json.encode(toMap());
  factory ModeloDiasTreino.fromJson(String source) =>
      ModeloDiasTreino.fromMap(json.decode(source));
}
