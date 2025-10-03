import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:nahora/app/core/exceptions/create_exception.dart';
import 'package:nahora/app/core/rest_client/rest_client.dart';
import 'package:nahora/app/src/models/response/produto_especifico_model_response.dart';
import 'package:nahora/app/src/models/response/promocoes_model_response.dart';

class MenuRepository {
  final RestClient restClient;
  MenuRepository({required this.restClient});

  Future<List<ProdutoEspecificoModelResponse>> buscaProdutosEspecificos(
    int menu,
  ) async {
    try {
      Response response = await restClient.unauth.get(
        "/menu",
        queryParameters: {'menu': menu},
      );
      return response.data
          .map<ProdutoEspecificoModelResponse>(
            (e) => ProdutoEspecificoModelResponse.fromMap(e),
          )
          .toList();
    } catch (e, s) {
      log("ExceptionErrorBuscaProdutosEspecificos: StrackTrace: $s");
      throw CreateException.dioException(e);
    }
  }

  Future<List<PromocoesModelResponse>> buscaPromocoesEspecificas(
    int menu,
  ) async {
    try {
      Response response = await restClient.unauth.get(
        "/promocoes/especificas",
        queryParameters: {'menu': menu},
      );
      return response.data
          .map<PromocoesModelResponse>((e) => PromocoesModelResponse.fromMap(e))
          .toList();
    } catch (e, s) {
      log("ExceptionErrorBuscaPromocoesGerais: StrackTrace: $s");
      throw CreateException.dioException(e);
    }
  }
}
