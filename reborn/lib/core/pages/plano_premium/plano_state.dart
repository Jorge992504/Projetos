// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:match/match.dart';
import 'package:reborn/core/modelos/payment_types_model.dart';

part 'plano_state.g.dart';

@match
enum PlanoStatus {
  initial,
  loaded,
  loading,
  updateOrder,
  error,
  confirmRemoveProduto,
  emptyBag,
  success,
}

class PlanoState extends Equatable {
  final PlanoStatus status;

  final List<PaymentTypesModel> paymentTypes;
  final String? errorMEssage;
  const PlanoState({
    required this.status,
    required this.paymentTypes,
    required this.errorMEssage,
  });

  const PlanoState.initial()
      : status = PlanoStatus.initial,
        paymentTypes = const [],
        errorMEssage = null;

  @override
  List<Object?> get props => [status, paymentTypes, errorMEssage];

  PlanoState copyWith({
    PlanoStatus? status,
    List<PaymentTypesModel>? paymentTypes,
    String? errorMEssage,
  }) {
    return PlanoState(
      status: status ?? this.status,
      paymentTypes: paymentTypes ?? this.paymentTypes,
      errorMEssage: errorMEssage ?? this.errorMEssage,
    );
  }
}

class OrderConfirmDeleteProdutoState extends PlanoState {
  final int index;

  const OrderConfirmDeleteProdutoState({
    required this.index,
    required super.status,
    required super.paymentTypes,
    required super.errorMEssage,
  });
}
