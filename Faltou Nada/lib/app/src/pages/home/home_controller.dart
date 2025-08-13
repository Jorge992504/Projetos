import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:faltou_nada/app/core/exceptions/repository_exception.dart';
import 'package:faltou_nada/app/src/models/product_model.dart';
import 'package:faltou_nada/app/src/pages/home/home_state.dart';
import 'package:faltou_nada/app/src/repository/home_repository.dart';

class HomeController extends Cubit<HomeState> {
  final HomeRepository _homeRepository;

  HomeController(this._homeRepository) : super(HomeState.initial());

  Future<void> findProduct() async {
    try {
      emit(state.copyWith(status: HomeStatus.loading));

      List<ProductModel> productsModel = await _homeRepository.findProduct();
      emit(state.copyWith(
          status: HomeStatus.loaded, productModel: productsModel));
    } on RepositoryException catch (e, s) {
      log('$s');
      emit(state.copyWith(status: HomeStatus.failure, errorMessage: e.message));
    }
  }
}
