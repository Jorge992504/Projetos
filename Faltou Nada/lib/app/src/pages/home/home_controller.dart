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

  Future<void> findProductFromUser() async {
    try {
      emit(state.copyWith(status: HomeStatus.loading));

      List<ProductModel> productsUser =
          await _homeRepository.findProductFromUser();
      emit(
          state.copyWith(status: HomeStatus.loaded, productUser: productsUser));
    } on RepositoryException catch (e, s) {
      log('$s');
      emit(state.copyWith(status: HomeStatus.failure, errorMessage: e.message));
    }
  }

  Future<bool> deleteProductFromUser(int productId) async {
    try {
      emit(state.copyWith(status: HomeStatus.loading));

      bool result = await _homeRepository.deleteProducyFromUser(productId);
      emit(state.copyWith(status: HomeStatus.success));
      return result;
    } on RepositoryException catch (e, s) {
      log('$s');
      emit(state.copyWith(status: HomeStatus.failure, errorMessage: e.message));
      return false;
    }
  }

  Future<bool> saveProductToUser(int productId) async {
    try {
      emit(state.copyWith(status: HomeStatus.loading));

      await _homeRepository.saveProductToUser(productId);
      emit(state.copyWith(status: HomeStatus.success));
      return true;
    } on RepositoryException catch (e, s) {
      log('$s');
      emit(state.copyWith(status: HomeStatus.failure, errorMessage: e.message));
      return false;
    }
  }

  Future<bool> saveProductForName(String productName) async {
    try {
      emit(state.copyWith(status: HomeStatus.loading));

      await _homeRepository.saveProductForName(productName);
      emit(state.copyWith(status: HomeStatus.success));
      return true;
    } on RepositoryException catch (e, s) {
      log('$s');
      emit(state.copyWith(status: HomeStatus.failure, errorMessage: e.message));
      return false;
    }
  }

  Future<void> refresh() async {
    try {
      emit(state.copyWith(status: HomeStatus.loading));

      List<ProductModel> productsUser =
          await _homeRepository.findProductFromUser();
      emit(
          state.copyWith(status: HomeStatus.loaded, productUser: productsUser));
    } on RepositoryException catch (e, s) {
      log('$s');
      emit(state.copyWith(status: HomeStatus.failure, errorMessage: e.message));
    }
  }
}
