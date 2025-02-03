import 'package:ishopping/core/errors/repository_exception.dart';
import 'package:ishopping/core/fp/either.dart';
import 'package:ishopping/core/fp/nil.dart';
import 'package:ishopping/src/models/products_model.dart';

abstract interface class IshoppingRepository {
  //GET
  Future<Either<RepositoryException, List<ProductsModel>>> getSelectProducts();
  Future<Either<RepositoryException, List<ProductsModel>>> getProducts(
      List<ProductsModel> name);

  //Post
  Future<Either<RepositoryException, Nil>> postProducts(
      ({int idProducts}) data);

  Future<Either<RepositoryException, Nil>> postNewProduct(({String name}) data);

  //DELETE
  Future<Either<RepositoryException, Nil>> deleteProduct(({int id}) data);
}
