// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PagamentoStatusRequest {
  int? paymentId;
  String? token;
  String? periodo;
  String? tipoPlano;
  num? valor;
  PagamentoStatusRequest({
    this.paymentId,
    this.token,
    this.periodo,
    this.tipoPlano,
    this.valor,
  });

  PagamentoStatusRequest copyWith({
    int? paymentId,
    String? token,
    String? periodo,
    String? tipoPlano,
    num? valor,
  }) {
    return PagamentoStatusRequest(
      paymentId: paymentId ?? this.paymentId,
      token: token ?? this.token,
      periodo: periodo ?? this.periodo,
      tipoPlano: tipoPlano ?? this.tipoPlano,
      valor: valor ?? this.valor,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'paymentId': paymentId,
      'token': token,
      'periodo': periodo,
      'tipoPlano': tipoPlano,
      'valor': valor,
    };
  }

  factory PagamentoStatusRequest.fromMap(Map<String, dynamic> map) {
    return PagamentoStatusRequest(
      paymentId: map['paymentId'] ?? 0,
      token: map['token'] ?? "",
      periodo: map['periodo'] ?? "",
      tipoPlano: map['tipoPlano'] ?? "",
      valor: map['valor'] ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory PagamentoStatusRequest.fromJson(String source) =>
      PagamentoStatusRequest.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  @override
  String toString() {
    return 'PagamentoStatusRequest(paymentId: $paymentId, token: $token, periodo: $periodo, tipoPlano: $tipoPlano, valor: $valor)';
  }

  @override
  bool operator ==(covariant PagamentoStatusRequest other) {
    if (identical(this, other)) return true;

    return other.paymentId == paymentId &&
        other.token == token &&
        other.periodo == periodo &&
        other.tipoPlano == tipoPlano &&
        other.valor == valor;
  }

  @override
  int get hashCode {
    return paymentId.hashCode ^
        token.hashCode ^
        periodo.hashCode ^
        tipoPlano.hashCode ^
        valor.hashCode;
  }
}
