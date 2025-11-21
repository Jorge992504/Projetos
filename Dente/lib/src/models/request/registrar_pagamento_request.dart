// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class RegistrarPagamentoRequest {
  int? agendamentoId;
  int? convenioId;
  String? tipoPagamento;
  String? status;
  num? valorCobrado;
  num? valorAtual;
  num? valorDesconto;
  bool? tratamentoFechado;
  num? valorLiquido;
  num? percentoDentista;
  RegistrarPagamentoRequest({
    this.agendamentoId,
    this.convenioId,
    this.tipoPagamento,
    this.status,
    this.valorCobrado,
    this.valorAtual,
    this.valorDesconto,
    this.tratamentoFechado,
    this.valorLiquido,
    this.percentoDentista,
  });

  RegistrarPagamentoRequest copyWith({
    int? agendamentoId,
    int? convenioId,
    String? tipoPagamento,
    String? status,
    num? valorCobrado,
    num? valorAtual,
    num? valorDesconto,
    bool? tratamentoFechado,
    num? valorLiquido,
    num? percentoDentista,
  }) {
    return RegistrarPagamentoRequest(
      agendamentoId: agendamentoId ?? this.agendamentoId,
      convenioId: convenioId ?? this.convenioId,
      tipoPagamento: tipoPagamento ?? this.tipoPagamento,
      status: status ?? this.status,
      valorCobrado: valorCobrado ?? this.valorCobrado,
      valorAtual: valorAtual ?? this.valorAtual,
      valorDesconto: valorDesconto ?? this.valorDesconto,
      tratamentoFechado: tratamentoFechado ?? this.tratamentoFechado,
      valorLiquido: valorLiquido ?? this.valorLiquido,
      percentoDentista: percentoDentista ?? this.percentoDentista,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'agendamentoId': agendamentoId,
      'convenioId': convenioId,
      'tipoPagamento': tipoPagamento,
      'status': status,
      'valorCobrado': valorCobrado,
      'valorAtual': valorAtual,
      'valorDesconto': valorDesconto,
      'tratamentoFechado': tratamentoFechado,
      'valorLiquido': valorLiquido,
      'percentoDentista': percentoDentista,
    };
  }

  factory RegistrarPagamentoRequest.fromMap(Map<String, dynamic> map) {
    return RegistrarPagamentoRequest(
      agendamentoId: map['agendamentoId'] ?? 0,
      convenioId: map['convenioId'] ?? 0,
      tipoPagamento: map['tipoPagamento'] ?? "",
      status: map['status'] ?? "",
      valorCobrado: map['valorCobrado'] ?? 0.0,
      valorAtual: map['valorAtual'] ?? 0.0,
      valorDesconto: map['valorDesconto'] ?? 0.0,
      tratamentoFechado: map['tratamentoFechado'] ?? false,
      valorLiquido: map['valorLiquido'] ?? 0.0,
      percentoDentista: map['percentoDentista'] ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory RegistrarPagamentoRequest.fromJson(String source) =>
      RegistrarPagamentoRequest.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  @override
  String toString() {
    return 'RegistrarPagamentoRequest(agendamentoId: $agendamentoId, convenioId: $convenioId, tipoPagamento: $tipoPagamento, status: $status, valorCobrado: $valorCobrado, valorAtual: $valorAtual, valorDesconto: $valorDesconto, tratamentoFechado: $tratamentoFechado, valorLiquido: $valorLiquido, percentoDentista: $percentoDentista)';
  }

  @override
  bool operator ==(covariant RegistrarPagamentoRequest other) {
    if (identical(this, other)) return true;

    return other.agendamentoId == agendamentoId &&
        other.convenioId == convenioId &&
        other.tipoPagamento == tipoPagamento &&
        other.status == status &&
        other.valorCobrado == valorCobrado &&
        other.valorAtual == valorAtual &&
        other.valorDesconto == valorDesconto &&
        other.tratamentoFechado == tratamentoFechado &&
        other.valorLiquido == valorLiquido &&
        other.percentoDentista == percentoDentista;
  }

  @override
  int get hashCode {
    return agendamentoId.hashCode ^
        convenioId.hashCode ^
        tipoPagamento.hashCode ^
        status.hashCode ^
        valorCobrado.hashCode ^
        valorAtual.hashCode ^
        valorDesconto.hashCode ^
        tratamentoFechado.hashCode ^
        valorLiquido.hashCode ^
        percentoDentista.hashCode;
  }
}
