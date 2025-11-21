import 'package:dente/src/models/response/buscar_convenios_pagamento_response.dart';
import 'package:match/match.dart';

part 'payment_state.g.dart';

@match
enum PaymentStatus { initial, loading, loaded, success, failure }

class PaymentState {
  final PaymentStatus status;
  final String? errorMessage;
  final List<BuscarConveniosPagamentoResponse>? conveniosPagamento;

  PaymentState.initial()
    : status = PaymentStatus.initial,
      errorMessage = null,
      conveniosPagamento = [];
  PaymentState({
    required this.status,
    this.errorMessage,
    this.conveniosPagamento,
  });

  PaymentState copyWith({
    PaymentStatus? status,
    String? errorMessage,
    List<BuscarConveniosPagamentoResponse>? conveniosPagamento,
  }) {
    return PaymentState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      conveniosPagamento: conveniosPagamento ?? this.conveniosPagamento,
    );
  }

  List<Object?> get props {
    return [status, errorMessage, conveniosPagamento];
  }
}
