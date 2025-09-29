// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UsuarioModel {
  String? email;
  String? nome;
  UsuarioModel({this.email, this.nome});

  UsuarioModel copyWith({String? email, String? nome}) {
    return UsuarioModel(email: email ?? this.email, nome: nome ?? this.nome);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'email': email, 'nome': nome};
  }

  factory UsuarioModel.fromMap(Map<String, dynamic> map) {
    return UsuarioModel(email: map['email'] ?? "", nome: map['nome'] ?? "");
  }

  String toJson() => json.encode(toMap());

  factory UsuarioModel.fromJson(String source) =>
      UsuarioModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'UsuarioModel(email: $email, nome: $nome)';

  @override
  bool operator ==(covariant UsuarioModel other) {
    if (identical(this, other)) return true;

    return other.email == email && other.nome == nome;
  }

  @override
  int get hashCode => email.hashCode ^ nome.hashCode;
}
