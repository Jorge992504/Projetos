import 'package:equatable/equatable.dart';
import 'package:match/match.dart';

import 'package:saborito/app/dto/order_produto_dto.dart';
import 'package:saborito/app/models/produto_model.dart';

part 'home_state.g.dart';

@match
enum HomeStateStatus {
  initial,
  loading,
  loaded,
  error,
}

class HomeState extends Equatable {
  final HomeStateStatus status;
  final List<ProdutoModel> produtos;
  final String? errorMessage;
  final List<OrderProdutoDto> shoppingBag;
  const HomeState({
    required this.shoppingBag,
    required this.status,
    required this.produtos,
    this.errorMessage,
  });
  const HomeState.initial()
      : status = HomeStateStatus.initial,
        produtos = const [],
        errorMessage = null,
        shoppingBag = const [];
  @override
  List<Object?> get props => [status, produtos, errorMessage, shoppingBag];

  HomeState copyWith({
    HomeStateStatus? status,
    List<ProdutoModel>? produtos,
    String? errorMessage,
    List<OrderProdutoDto>? shoppingBag,
  }) {
    return HomeState(
      status: status ?? this.status,
      produtos: produtos ?? this.produtos,
      errorMessage: errorMessage ?? this.errorMessage,
      shoppingBag: shoppingBag ?? this.shoppingBag,
    );
  }
}
