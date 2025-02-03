// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ishopping/core/errors/repository_exception.dart';
import 'package:ishopping/core/fp/either.dart';
import 'package:ishopping/core/fp/nil.dart';
import 'package:ishopping/core/restClient/rest_client.dart';
import 'package:ishopping/src/models/products_model.dart';
import 'package:ishopping/src/repositories/repository_geral/ishopping_repository.dart';

class IshoppingRepositoryImpl implements IshoppingRepository {
  final RestClient restClient;
  IshoppingRepositoryImpl({
    required this.restClient,
  });

  //GETS
  @override
  Future<Either<RepositoryException, List<ProductsModel>>>
      getSelectProducts() async {
    try {
      final Response<List> response =
          await restClient.auth.get('/select/products');
      List<ProductsModel> products =
          response.data?.map((e) => ProductsModel.fromMap(e)).toList() ?? [];
      return Success(products);
    } on DioException catch (e, s) {
      log('|--------------GET-select-products-----------|');
      log('| Error: ', error: e.error, stackTrace: s);
      log('| Message do erro: ', error: e.message);
      log('|--------------------------------------------|');
      throw Failure(
          Exception('Erro ao buscar os produtos selecionados pelo usuário'));
    }
  }

  @override
  Future<Either<RepositoryException, List<ProductsModel>>> getProducts(
      List<ProductsModel> name) async {
    try {
      final Response<List> response = await restClient.unauth.get(
        '/products',
        queryParameters: {'name': name},
      );
      List<ProductsModel> products =
          response.data?.map((e) => ProductsModel.fromMap(e)).toList() ?? [];
      return Success(products);
    } on DioException catch (e, s) {
      log('| Error: ', error: e.error, stackTrace: s);
      log('| Message do erro: ', error: e.message);
      throw Failure(Exception('Erro ao pesquisar por produto'));
    }
  }

  //POSTS
  @override
  Future<Either<RepositoryException, Nil>> postProducts(
      ({int idProducts}) data) async {
    try {
      await restClient.auth.post('/select/products', data: {
        'user_id': '#userAuthRef',
        'product_id': data.idProducts,
      });
      return Success(nil);
    } on DioException catch (e, s) {
      log('Erro ao guardar o produto', error: e.error, stackTrace: s);
      log('Message do erro: ', error: e.message);
      return Failure(RepositoryException(message: 'Erro oa guardar o produto'));
    }
  }

  @override
  Future<Either<RepositoryException, Nil>> postNewProduct(
      ({String name}) data) async {
    try {
      await restClient.auth.post('/select/products/new', data: {
        'user_id': '#userAuthRef',
        'name': data.name,
      });
      return Success(nil);
    } on DioException catch (e, s) {
      log('Erro ao guardar o novo produto', error: e.error, stackTrace: s);
      log('Message do erro: ', error: e.message);
      return Failure(
          RepositoryException(message: 'Erro oa guardar o novo produto'));
    }
  }

  //DELETE

  @override
  Future<Either<RepositoryException, Nil>> deleteProduct(
      ({int id}) data) async {
    try {
      await restClient.auth.delete('/select/products', data: {
        'user_id': '#userAuthRef',
        'product_id': data.id,
      });
      return Success(nil);
    } on DioException catch (e, s) {
      log('Erro ao deletar o produto', error: e.error, stackTrace: s);
      log('Message do erro: ', error: e.message);
      return Failure(RepositoryException(message: 'Erro oa deletar o produto'));
    }
  }
}
