import 'package:faltou_nada/app/src/models/product_model.dart';
import 'package:match/match.dart';

part 'home_state.g.dart';

@match
enum HomeStatus {
  initial,
  loading,
  loaded,
  success,
  refresg,
  failure,
}

class HomeState {
  final HomeStatus status;
  final String? errorMessage;
  final List<ProductModel>? productModel;
  HomeState.initial()
      : status = HomeStatus.initial,
        errorMessage = null,
        productModel = [];
  HomeState({
    required this.status,
    this.errorMessage,
    this.productModel,
  });

  HomeState copyWith({
    HomeStatus? status,
    String? errorMessage,
    List<ProductModel>? productModel,
  }) {
    return HomeState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      productModel: productModel ?? this.productModel,
    );
  }

  List<Object?> get props {
    return [
      status,
      errorMessage,
      productModel,
    ];
  }
}
