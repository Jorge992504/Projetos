import 'dart:convert';

class ModeloExercicio {
  late String nome;
  late int id;
  late String descricao;
  late String video;
  late String repeticoes;

  ModeloExercicio({
    required this.nome,
    required this.id,
    required this.descricao,
    required this.repeticoes,
    required this.video,
  });

  ModeloExercicio.fromModeloExercicio() {
    nome = "";
    id = 0;
    descricao = "";
    repeticoes = "";
    video = "";
  }

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'id': id,
      'descricao': descricao,
    };
  }

  factory ModeloExercicio.fromMap(Map<String, dynamic> map) {
    return ModeloExercicio(
      nome: map['nome']?.toString() ?? '',
      id: map['id']?.toInt() ?? 0,
      descricao: map['descricao']?.toString() ?? '',
      repeticoes: map['video']?.toString() ?? '',
      video: map['video']?.toString() ?? '',
    );
  }
  String toJson() => json.encode(toMap());
  factory ModeloExercicio.fromJson(String source) =>
      ModeloExercicio.fromMap(json.decode(source));
}
