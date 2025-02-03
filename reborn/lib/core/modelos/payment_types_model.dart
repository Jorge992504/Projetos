import 'dart:convert';

class PaymentTypesModel {
  final int id;
  final String nome;
  final String acronym;
  final bool enabled;
  PaymentTypesModel({
    required this.id,
    required this.nome,
    required this.acronym,
    required this.enabled,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nome': nome,
      'acronym': acronym,
      'enabled': enabled,
    };
  }

  factory PaymentTypesModel.fromMap(Map<String, dynamic> map) {
    return PaymentTypesModel(
      id: map['id'] as int,
      nome: map['nome'] as String,
      acronym: map['acronym'] as String,
      enabled: map['enabled'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentTypesModel.fromJson(String source) =>
      PaymentTypesModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
