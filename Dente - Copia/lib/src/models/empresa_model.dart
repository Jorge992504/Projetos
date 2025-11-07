// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class EmpresaModel {
  String? foto;
  String? nomeClinica;
  String? emailClinica;
  String? telefone;
  String? endereco;
  String? passowrd;
  String? cnpj;
  EmpresaModel({
    this.foto,
    this.nomeClinica,
    this.emailClinica,
    this.telefone,
    this.endereco,
    this.passowrd,
    this.cnpj,
  });

  EmpresaModel copyWith({
    String? foto,
    String? nomeClinica,
    String? emailClinica,
    String? telefone,
    String? endereco,
    String? passowrd,
    String? cnpj,
  }) {
    return EmpresaModel(
      foto: foto ?? this.foto,
      nomeClinica: nomeClinica ?? this.nomeClinica,
      emailClinica: emailClinica ?? this.emailClinica,
      telefone: telefone ?? this.telefone,
      endereco: endereco ?? this.endereco,
      passowrd: passowrd ?? this.passowrd,
      cnpj: cnpj ?? this.cnpj,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'foto': foto,
      'nomeClinica': nomeClinica,
      'emailClinica': emailClinica,
      'telefone': telefone,
      'endereco': endereco,
      'passowrd': passowrd,
      'cnpj': cnpj,
    };
  }

  factory EmpresaModel.fromMap(Map<String, dynamic> map) {
    return EmpresaModel(
      foto: map['foto'] ?? "",
      nomeClinica: map['nomeClinica'] ?? "",
      emailClinica: map['emailClinica'] ?? "",
      telefone: map['telefone'] ?? "",
      endereco: map['endereco'] ?? "",
      passowrd: map['passowrd'] ?? "",
      cnpj: map['cnpj'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory EmpresaModel.fromJson(String source) =>
      EmpresaModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'EmpresaModel(foto: $foto, nomeClinica: $nomeClinica, emailClinica: $emailClinica, telefone: $telefone, endereco: $endereco, passowrd: $passowrd, cnpj: $cnpj)';
  }

  @override
  bool operator ==(covariant EmpresaModel other) {
    if (identical(this, other)) return true;

    return other.foto == foto &&
        other.nomeClinica == nomeClinica &&
        other.emailClinica == emailClinica &&
        other.telefone == telefone &&
        other.endereco == endereco &&
        other.passowrd == passowrd &&
        other.cnpj == cnpj;
  }

  @override
  int get hashCode {
    return foto.hashCode ^
        nomeClinica.hashCode ^
        emailClinica.hashCode ^
        telefone.hashCode ^
        endereco.hashCode ^
        passowrd.hashCode ^
        cnpj.hashCode;
  }
}
