// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PacienteModel {
  String? nome;
  String? email;
  String? telefone;
  String? endereco;
  String? cpf;
  PacienteModel({
    this.nome,
    this.email,
    this.telefone,
    this.endereco,
    this.cpf,
  });

  PacienteModel copyWith({
    String? nome,
    String? email,
    String? telefone,
    String? endereco,
    String? cpf,
  }) {
    return PacienteModel(
      nome: nome ?? this.nome,
      email: email ?? this.email,
      telefone: telefone ?? this.telefone,
      endereco: endereco ?? this.endereco,
      cpf: cpf ?? this.cpf,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nome': nome,
      'email': email,
      'telefone': telefone,
      'endereco': endereco,
      'cpf': cpf,
    };
  }

  factory PacienteModel.fromMap(Map<String, dynamic> map) {
    return PacienteModel(
      nome: map['nome'] ?? "",
      email: map['email'] ?? "",
      telefone: map['telefone'] ?? "",
      endereco: map['endereco'] ?? "",
      cpf: map['cpf'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory PacienteModel.fromJson(String source) =>
      PacienteModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PacienteModel(nome: $nome, email: $email, telefone: $telefone, endereco: $endereco, cpf: $cpf)';
  }

  @override
  bool operator ==(covariant PacienteModel other) {
    if (identical(this, other)) return true;

    return other.nome == nome &&
        other.email == email &&
        other.telefone == telefone &&
        other.endereco == endereco &&
        other.cpf == cpf;
  }

  @override
  int get hashCode {
    return nome.hashCode ^
        email.hashCode ^
        telefone.hashCode ^
        endereco.hashCode ^
        cpf.hashCode;
  }

  String? rg;
}
