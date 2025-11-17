// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:dente/src/models/response/relatorio_agendamento_response.dart';

class RelatorioAgendamentoCabecaResponse {
  String? tipo;
  String? inicio;
  String? fim;
  int? total;
  int? realizados;
  int? pendentes;
  int? cancelados;
  List<RelatorioAgendamentoResponse>? agendamentos;
  RelatorioAgendamentoCabecaResponse({
    this.tipo,
    this.inicio,
    this.fim,
    this.total,
    this.realizados,
    this.pendentes,
    this.cancelados,
    this.agendamentos,
  });

  RelatorioAgendamentoCabecaResponse copyWith({
    String? tipo,
    String? inicio,
    String? fim,
    int? total,
    int? realizados,
    int? pendentes,
    int? cancelados,
    List<RelatorioAgendamentoResponse>? agendamentos,
  }) {
    return RelatorioAgendamentoCabecaResponse(
      tipo: tipo ?? this.tipo,
      inicio: inicio ?? this.inicio,
      fim: fim ?? this.fim,
      total: total ?? this.total,
      realizados: realizados ?? this.realizados,
      pendentes: pendentes ?? this.pendentes,
      cancelados: cancelados ?? this.cancelados,
      agendamentos: agendamentos ?? this.agendamentos,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'tipo': tipo,
      'inicio': inicio,
      'fim': fim,
      'total': total,
      'realizados': realizados,
      'pendentes': pendentes,
      'cancelados': cancelados,
      'agendamentos': agendamentos?.map((x) => x.toMap()).toList(),
    };
  }

  factory RelatorioAgendamentoCabecaResponse.fromMap(Map<String, dynamic> map) {
    return RelatorioAgendamentoCabecaResponse(
      tipo: map['tipo'] ?? "",
      inicio: map['inicio'] ?? "",
      fim: map['fim'] ?? "",
      total: map['total'] ?? 0,
      realizados: map['realizados'] ?? 0,
      pendentes: map['pendentes'] ?? 0,
      cancelados: map['cancelados'] ?? 0,
      agendamentos: (map['agendamentos'] as List)
          .map((e) => RelatorioAgendamentoResponse.fromMap(e))
          .toList(),
    );
  }

  String toJson() => json.encode(toMap());

  factory RelatorioAgendamentoCabecaResponse.fromJson(String source) =>
      RelatorioAgendamentoCabecaResponse.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  @override
  String toString() {
    return 'RelatorioAgendamentoCabecaResponse(tipo: $tipo, inicio: $inicio, fim: $fim, total: $total, realizados: $realizados, pendentes: $pendentes, cancelados: $cancelados, agendamentos: $agendamentos)';
  }

  @override
  bool operator ==(covariant RelatorioAgendamentoCabecaResponse other) {
    if (identical(this, other)) return true;

    return other.tipo == tipo &&
        other.inicio == inicio &&
        other.fim == fim &&
        other.total == total &&
        other.realizados == realizados &&
        other.pendentes == pendentes &&
        other.cancelados == cancelados &&
        listEquals(other.agendamentos, agendamentos);
  }

  @override
  int get hashCode {
    return tipo.hashCode ^
        inicio.hashCode ^
        fim.hashCode ^
        total.hashCode ^
        realizados.hashCode ^
        pendentes.hashCode ^
        cancelados.hashCode ^
        agendamentos.hashCode;
  }
}
