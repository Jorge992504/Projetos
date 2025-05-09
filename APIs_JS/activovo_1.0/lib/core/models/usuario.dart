import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Usuario {
  final String nome;
  final String sobrenome;
  final String email;
  final DateTime dataNasc;
  final double peco;
  final double altura;
  final String usua;
  final String senha;
  final String doenca;
  final bool doencaSim;
  Usuario({
    required this.nome,
    required this.sobrenome,
    required this.email,
    required this.dataNasc,
    required this.peco,
    required this.altura,
    required this.usua,
    required this.senha,
    required this.doenca,
    required this.doencaSim,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nome': nome,
      'sobrenome': sobrenome,
      'email': email,
      'dataNasc': dataNasc.millisecondsSinceEpoch,
      'peco': peco,
      'altura': altura,
      'usua': usua,
      'senha': senha,
      'doenca': doenca,
      'doencaSim': doencaSim,
    };
  }

  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
      nome: map['nome'] as String,
      sobrenome: map['sobrenome'] as String,
      email: map['email'] as String,
      dataNasc: DateTime.fromMillisecondsSinceEpoch(map['dataNasc'] as int),
      peco: map['peco'] as double,
      altura: map['altura'] as double,
      usua: map['usua'] as String,
      senha: map['senha'] as String,
      doenca: map['doenca'] as String,
      doencaSim: map['doencaSim'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Usuario.fromJson(String source) =>
      Usuario.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Usuario(nome: $nome, sobrenome: $sobrenome, email: $email, dataNasc: $dataNasc, peco: $peco, altura: $altura, usua: $usua, senha: $senha, doenca: $doenca, doencaSim: $doencaSim)';
  }
}
