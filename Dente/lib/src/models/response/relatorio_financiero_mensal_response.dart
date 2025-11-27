// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class RelatorioFinancieroMensalResponse {
  String? mes;
  num? valorTotal;
  List<ItensRelatorioFinancieroMensalResponse>? itens;
  RelatorioFinancieroMensalResponse({this.mes, this.valorTotal, this.itens});

  RelatorioFinancieroMensalResponse copyWith({
    String? mes,
    num? valorTotal,
    List<ItensRelatorioFinancieroMensalResponse>? itens,
  }) {
    return RelatorioFinancieroMensalResponse(
      mes: mes ?? this.mes,
      valorTotal: valorTotal ?? this.valorTotal,
      itens: itens ?? this.itens,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'mes': mes,
      'valorTotal': valorTotal,
      'itens': itens?.map((x) => x.toMap()).toList(),
    };
  }

  factory RelatorioFinancieroMensalResponse.fromMap(Map<String, dynamic> map) {
    return RelatorioFinancieroMensalResponse(
      mes: map['mes'] ?? "",
      valorTotal: map['valorTotal'] ?? 0.0,
      itens: (map['itens'] as List)
          .map((e) => ItensRelatorioFinancieroMensalResponse.fromMap(e))
          .toList(),
    );
  }

  String toJson() => json.encode(toMap());

  factory RelatorioFinancieroMensalResponse.fromJson(String source) =>
      RelatorioFinancieroMensalResponse.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  @override
  String toString() =>
      'RelatorioFinancieroMensalResponse(mes: $mes, valorTotal: $valorTotal, itens: $itens)';

  @override
  bool operator ==(covariant RelatorioFinancieroMensalResponse other) {
    if (identical(this, other)) return true;

    return other.mes == mes &&
        other.valorTotal == valorTotal &&
        listEquals(other.itens, itens);
  }

  @override
  int get hashCode => mes.hashCode ^ valorTotal.hashCode ^ itens.hashCode;
}

class ItensRelatorioFinancieroMensalResponse {
  String? dataPagamento;
  String? servico;
  num? valorRecebido;
  num? desconto;
  ItensRelatorioFinancieroMensalResponse({
    this.dataPagamento,
    this.servico,
    this.valorRecebido,
    this.desconto,
  });

  ItensRelatorioFinancieroMensalResponse copyWith({
    String? dataPagamento,
    String? servico,
    num? valorRecebido,
    num? desconto,
  }) {
    return ItensRelatorioFinancieroMensalResponse(
      dataPagamento: dataPagamento ?? this.dataPagamento,
      servico: servico ?? this.servico,
      valorRecebido: valorRecebido ?? this.valorRecebido,
      desconto: desconto ?? this.desconto,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'dataPagamento': dataPagamento,
      'servico': servico,
      'valorRecebido': valorRecebido,
      'desconto': desconto,
    };
  }

  factory ItensRelatorioFinancieroMensalResponse.fromMap(
    Map<String, dynamic> map,
  ) {
    return ItensRelatorioFinancieroMensalResponse(
      dataPagamento: map['dataPagamento'] ?? "",
      servico: map['servico'] ?? "",
      valorRecebido: map['valorRecebido'] ?? 0.0,
      desconto: map['desconto'] ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ItensRelatorioFinancieroMensalResponse.fromJson(String source) =>
      ItensRelatorioFinancieroMensalResponse.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  @override
  String toString() {
    return 'ItensRelatorioFinancieroMensalResponse(dataPagamento: $dataPagamento, servico: $servico, valorRecebido: $valorRecebido, desconto: $desconto)';
  }

  @override
  bool operator ==(covariant ItensRelatorioFinancieroMensalResponse other) {
    if (identical(this, other)) return true;

    return other.dataPagamento == dataPagamento &&
        other.servico == servico &&
        other.valorRecebido == valorRecebido &&
        other.desconto == desconto;
  }

  @override
  int get hashCode {
    return dataPagamento.hashCode ^
        servico.hashCode ^
        valorRecebido.hashCode ^
        desconto.hashCode;
  }
}
