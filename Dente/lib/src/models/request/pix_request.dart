// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PixRequest {
  num? valor;
  String? descricao;

  String? email;
  String? name;
  String? cnpj;
  PixRequest({this.valor, this.descricao, this.email, this.name, this.cnpj});

  PixRequest copyWith({
    num? valor,
    String? descricao,
    String? email,
    String? name,
    String? cnpj,
  }) {
    return PixRequest(
      valor: valor ?? this.valor,
      descricao: descricao ?? this.descricao,
      email: email ?? this.email,
      name: name ?? this.name,
      cnpj: cnpj ?? this.cnpj,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'valor': valor,
      'descricao': descricao,
      'email': email,
      'name': name,
      'cnpj': cnpj,
    };
  }

  factory PixRequest.fromMap(Map<String, dynamic> map) {
    return PixRequest(
      valor: map['valor'] ?? 0.0,
      descricao: map['descricao'] ?? "",
      email: map['email'] ?? "",
      name: map['name'] ?? "",
      cnpj: map['cnpj'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory PixRequest.fromJson(String source) =>
      PixRequest.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PixRequest(valor: $valor, descricao: $descricao, email: $email, name: $name, cnpj: $cnpj)';
  }

  @override
  bool operator ==(covariant PixRequest other) {
    if (identical(this, other)) return true;

    return other.valor == valor &&
        other.descricao == descricao &&
        other.email == email &&
        other.name == name &&
        other.cnpj == cnpj;
  }

  @override
  int get hashCode {
    return valor.hashCode ^
        descricao.hashCode ^
        email.hashCode ^
        name.hashCode ^
        cnpj.hashCode;
  }
}
