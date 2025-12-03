// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class PrecosModelResponse {
  num? preco;
  String? plano;
  num? desconto;
  bool? promocao;
  num? precoPromocao;
  List<String>? funcionalidades;
  PrecosModelResponse({
    this.preco,
    this.plano,
    this.desconto,
    this.promocao,
    this.precoPromocao,
    this.funcionalidades,
  });

  PrecosModelResponse copyWith({
    num? preco,
    String? plano,
    num? desconto,
    bool? promocao,
    num? precoPromocao,
    List<String>? funcionalidades,
  }) {
    return PrecosModelResponse(
      preco: preco ?? this.preco,
      plano: plano ?? this.plano,
      desconto: desconto ?? this.desconto,
      promocao: promocao ?? this.promocao,
      precoPromocao: precoPromocao ?? this.precoPromocao,
      funcionalidades: funcionalidades ?? this.funcionalidades,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'preco': preco,
      'plano': plano,
      'desconto': desconto,
      'promocao': promocao,
      'precoPromocao': precoPromocao,
      'funcionalidades': funcionalidades,
    };
  }

  factory PrecosModelResponse.fromMap(Map<String, dynamic> map) {
    return PrecosModelResponse(
      preco: map['preco'] ?? 0.0,
      plano: map['plano'] ?? "",
      desconto: map['desconto'] ?? 0.0,
      promocao: map['promocao'] ?? false,
      precoPromocao: map['precoPromocao'] ?? 0.0,
      funcionalidades: List<String>.from(map['funcionalidades'] ?? []),
    );
  }

  String toJson() => json.encode(toMap());

  factory PrecosModelResponse.fromJson(String source) =>
      PrecosModelResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PrecosModelResponse(preco: $preco, plano: $plano, desconto: $desconto, promocao: $promocao, precoPromocao: $precoPromocao, funcionalidades: $funcionalidades)';
  }

  @override
  bool operator ==(covariant PrecosModelResponse other) {
    if (identical(this, other)) return true;

    return other.preco == preco &&
        other.plano == plano &&
        other.desconto == desconto &&
        other.promocao == promocao &&
        other.precoPromocao == precoPromocao &&
        listEquals(other.funcionalidades, funcionalidades);
  }

  @override
  int get hashCode {
    return preco.hashCode ^
        plano.hashCode ^
        desconto.hashCode ^
        promocao.hashCode ^
        precoPromocao.hashCode ^
        funcionalidades.hashCode;
  }
}
