import 'dart:developer';

import 'package:faltou_nada/app/core/exceptions/create_exception.dart';
import 'package:faltou_nada/app/core/rest_client/rest_client.dart';
import 'package:faltou_nada/app/src/models/product_model.dart';

class HomeRepository {
  final RestClient restClient;
  HomeRepository({
    required this.restClient,
  });

  Future<List<ProductModel>> findProduct() async {
    try {
      final result = await restClient.auth.get(
        "/products",
      );
      return result.data!
          .map<ProductModel>((e) => ProductModel.fromMap(e))
          .toList();
    } catch (e, s) {
      log('Erro ao buscar produtos', error: e, stackTrace: s);
      throw CreateException.dioException(e, 'Erro ao buscar produto');
    }
  }
}
