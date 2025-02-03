// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ishopping/src/models/products_model.dart';

enum HomeStateStatus {
  loaded,
  erro,
}

class HomeState {
  final HomeStateStatus status;
  final List<ProductsModel> products;
  HomeState({
    required this.status,
    required this.products,
  });

  HomeState copyWith({
    HomeStateStatus? status,
    List<ProductsModel>? products,
  }) {
    return HomeState(
      status: status ?? this.status,
      products: products ?? this.products,
    );
  }
}
