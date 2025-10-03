import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:nahora/app/core/exceptions/create_exception.dart';
import 'package:nahora/app/core/rest_client/rest_client.dart';
import 'package:nahora/app/src/models/response/promocoes_model_response.dart';

class HomeRepository {
  final RestClient restClient;
  HomeRepository({required this.restClient});

  Future<List<PromocoesModelResponse>> buscaPromocoesGerais() async {
    try {
      Response response = await restClient.unauth.get("/promocoes/gerais");
      return response.data
          .map<PromocoesModelResponse>((e) => PromocoesModelResponse.fromMap(e))
          .toList();
    } catch (e, s) {
      log("ExceptionErrorBuscaPromocoesGerais: StrackTrace: $s");
      throw CreateException.dioException(e);
    }
  }
}
