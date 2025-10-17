// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DentistaModel {
  String? nome;
  String? email;
  String? telefone;
  String? cro;
  bool? ativo;
  DentistaModel({this.nome, this.email, this.telefone, this.cro, this.ativo});

  DentistaModel copyWith({
    String? nome,
    String? email,
    String? telefone,
    String? cro,
    bool? ativo,
  }) {
    return DentistaModel(
      nome: nome ?? this.nome,
      email: email ?? this.email,
      telefone: telefone ?? this.telefone,
      cro: cro ?? this.cro,
      ativo: ativo ?? this.ativo,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nome': nome,
      'email': email,
      'telefone': telefone,
      'cro': cro,
      'ativo': ativo,
    };
  }

  factory DentistaModel.fromMap(Map<String, dynamic> map) {
    return DentistaModel(
      nome: map['nome'] ?? "",
      email: map['email'] ?? "",
      telefone: map['telefone'] ?? "",
      cro: map['cro'] ?? "",
      ativo: map['ativo'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory DentistaModel.fromJson(String source) =>
      DentistaModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DentistaModel(nome: $nome, email: $email, telefone: $telefone, cro: $cro, ativo: $ativo)';
  }

  @override
  bool operator ==(covariant DentistaModel other) {
    if (identical(this, other)) return true;

    return other.nome == nome &&
        other.email == email &&
        other.telefone == telefone &&
        other.cro == cro &&
        other.ativo == ativo;
  }

  @override
  int get hashCode {
    return nome.hashCode ^
        email.hashCode ^
        telefone.hashCode ^
        cro.hashCode ^
        ativo.hashCode;
  }
}
