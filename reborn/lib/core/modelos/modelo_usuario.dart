import 'dart:convert';

import 'package:intl/intl.dart';

class ModeloUsuario {
  late int id;
  late String usuario;
  late String nome;
  late String senha;
  late String sobrenome;
  late double peso;
  late double altura;
  late String email;
  late DateTime datanascimento;
  late String foto;

  ModeloUsuario({
    required this.id,
    required this.usuario,
    required this.nome,
    required this.senha,
    required this.sobrenome,
    required this.peso,
    required this.altura,
    required this.email,
    required this.datanascimento,
    required this.foto,
  });

  ModeloUsuario.fromModeloUsuario() {
    id = 0;
    usuario = "";
    nome = "";
    senha = "";
    sobrenome = "";
    peso = 0;
    altura = 0;
    email = "";
    datanascimento = DateTime.now();
    foto = "";
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'usuario': usuario,
      'senha': senha,
      'nome': nome,
      'sobrenome': sobrenome,
      'peso': peso,
      'altura': altura,
      'email': email,
      'datanascimento': datanascimento,
      'foto': foto,
    };
  }

  factory ModeloUsuario.fromMap(Map<String, dynamic> map) {
    return ModeloUsuario(
      id: map['id']?.toInt() ?? 0,
      usuario: map['usuario']?.toString() ?? '',
      nome: map['nome']?.toString() ?? '',
      senha: map['senha']?.toString() ?? '',
      sobrenome: map['sobrenome']?.toString() ?? '',
      peso: map['peso']?.toDouble() ?? 0.0,

      altura: map['altura']?.toDouble() ?? 0.0,
      email: map['email']?.toString() ?? '',
      //nascimento: DateFormat("yyyyMMdd").parse(map['nascimento'] as String),
      datanascimento: DateFormat("yyyy-MM-dd").parse(map['datanascimento']),
      foto: map['foto']?.toString() ?? '',
    );
  }
  String toJson() => json.encode(toMap());
  factory ModeloUsuario.fromJson(String source) =>
      ModeloUsuario.fromMap(json.decode(source));
}
