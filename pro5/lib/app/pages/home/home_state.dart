// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:match/match.dart';

import 'package:delivery/app/dto/ordem_produto_dto.dart';
import 'package:delivery/app/models/prod_mod.dart';

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
  final List<ProdMod> products;
  final String? errorMessage;
  final List<OrdemProduto> shoppingBag;

  const HomeState({
    required this.status,
    required this.products,
    required this.shoppingBag,
    this.errorMessage,
  });

  HomeState copyWith({
    HomeStateStatus? status,
    List<ProdMod>? products,
    String? errorMessage,
    List<OrdemProduto>? shoppingBag,
  }) {
    return HomeState(
      status: status ?? this.status,
      products: products ?? this.products,
      errorMessage: errorMessage ?? this.errorMessage,
      shoppingBag: shoppingBag ?? this.shoppingBag,
    );
  }

  @override
  List<Object?> get props => [status, products, errorMessage, shoppingBag];

  const HomeState.initial()
      : status = HomeStateStatus.initial,
        errorMessage = null,
        products = const [],
        shoppingBag = const [];
}
