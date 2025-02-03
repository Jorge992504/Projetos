// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:match/match.dart';

import 'package:delivery/app/dto/ordem_produto_dto.dart';
import 'package:delivery/app/models/payment_types_model.dart';

part 'order_state.g.dart';

@match
enum OrderStatus {
  initial,
  loaded,
  loading,
  updateOrder,
  error,
  confirmRemoveProduto,
  emptyBag,
  success,
}

class OrderState extends Equatable {
  final OrderStatus status;
  final List<OrdemProduto> orderProdutos;
  final List<PaymentTypesModel> paymentTypes;
  final String? errorMEssage;
  const OrderState({
    required this.status,
    required this.orderProdutos,
    required this.paymentTypes,
    required this.errorMEssage,
  });

  const OrderState.initial()
      : status = OrderStatus.initial,
        orderProdutos = const [],
        paymentTypes = const [],
        errorMEssage = null;
  double get totalOrder => orderProdutos.fold(
      0.0, (previousValue, element) => previousValue + element.totalPreco);

  @override
  List<Object?> get props =>
      [status, orderProdutos, paymentTypes, errorMEssage];

  OrderState copyWith({
    OrderStatus? status,
    List<OrdemProduto>? orderProdutos,
    List<PaymentTypesModel>? paymentTypes,
    String? errorMEssage,
  }) {
    return OrderState(
      status: status ?? this.status,
      orderProdutos: orderProdutos ?? this.orderProdutos,
      paymentTypes: paymentTypes ?? this.paymentTypes,
      errorMEssage: errorMEssage ?? this.errorMEssage,
    );
  }
}

class OrderConfirmDeleteProdutoState extends OrderState {
  final OrdemProduto ordemProduto;
  final int index;

  const OrderConfirmDeleteProdutoState({
    required this.ordemProduto,
    required this.index,
    required super.status,
    required super.orderProdutos,
    required super.paymentTypes,
    required super.errorMEssage,
  });
}
