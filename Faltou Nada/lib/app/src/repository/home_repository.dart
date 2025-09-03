import 'dart:developer';
import 'package:faltou_nada/app/core/exceptions/create_exception.dart';
import 'package:faltou_nada/app/core/rest_client/rest_client.dart';
import 'package:faltou_nada/app/src/models/product_model.dart';

class HomeRepository {
  final RestClient restClient;
  HomeRepository({required this.restClient});

  Future<List<ProductModel>> findProduct() async {
    try {
      final result = await restClient.auth.get("/products");
      return result.data!
          .map<ProductModel>((e) => ProductModel.fromMap(e))
          .toList();
    } catch (e, s) {
      log('Erro ao buscar produtos', error: e, stackTrace: s);
      throw CreateException.dioException(e);
    }
  }

  Future<List<ProductModel>> findProductFromUser() async {
    try {
      final result = await restClient.auth.get("/products/user");
      return result.data!
          .map<ProductModel>((e) => ProductModel.fromMap(e))
          .toList();
    } catch (e, s) {
      log('Erro ao buscar produtos do usuário', error: e, stackTrace: s);
      throw CreateException.dioException(e);
    }
  }

  Future<bool> deleteProducyFromUser(int productId) async {
    try {
      await restClient.auth.delete(
        "/products",
        queryParameters: {'productId': productId},
      );
      return true;
    } catch (e, s) {
      log('Erro ao excluir produto da lista', error: e, stackTrace: s);
      throw CreateException.dioException(e);
    }
  }

  Future<void> saveProductToUser(int productId) async {
    try {
      await restClient.auth.post(
        "/products",
        queryParameters: {'productId': productId},
      );
    } catch (e, s) {
      log('Erro ao salvar produto na lista', error: e, stackTrace: s);
      throw CreateException.dioException(e);
    }
  }

  Future<void> saveProductForName(String productName) async {
    try {
      await restClient.auth.post(
        "/products/name",
        queryParameters: {'productName': productName},
      );
    } catch (e, s) {
      log('Erro ao salvar produto na lista', error: e, stackTrace: s);
      throw CreateException.dioException(e);
    }
  }

  Future<void> enviarUrl(String url) async {
    try {
      await restClient.auth.post("/nfe", queryParameters: {'url': url});
    } catch (e, s) {
      log('Erro ao gravar preços', error: e, stackTrace: s);
      throw CreateException.dioException(e);
    }
  }
}
