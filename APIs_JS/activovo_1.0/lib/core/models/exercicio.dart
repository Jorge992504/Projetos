import 'dart:convert';

class Exercicio {
  final int id;
  final String nome;
  final String descricao;

  Exercicio({
    required this.id,
    required this.nome,
    required this.descricao,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'descricao': descricao,
    };
  }

  factory Exercicio.fromMap(Map<String, dynamic> map) {
    return Exercicio(
      id: map['id']?.toInt() ?? 0,
      nome: map['nome']?.toString() ?? '',
      descricao: map['descricao']?.toString() ?? '',
    );
  }
  String toJson() => json.encode(toMap());

  factory Exercicio.fromJson(String source) =>
      Exercicio.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Usuario(nome: $nome, descricao: $descricao)';
  }
}

class EscExercicio {
  List<String> exercicios1  = ['Exercicio 1º'];
  List<String> exercicios2  = ['Exercicio 2º'];
  List<String> exercicios3  = ['Exercicio 3º'];
  
}
