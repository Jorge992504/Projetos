import 'dart:developer';

import 'package:dente/core/exceptions/create_exception.dart';
import 'package:dente/core/rest_client/rest_client.dart';
import 'package:dente/src/models/request/card_request.dart';
import 'package:dente/src/models/request/pix_request.dart';
import 'package:dente/src/models/response/card_response.dart';
import 'package:dente/src/models/response/card_status_response.dart';
import 'package:dente/src/models/response/pix_response.dart';
import 'package:dente/src/models/response/precos_model_response.dart';

class PlanoRepository {
  final RestClient restClient;
  PlanoRepository({required this.restClient});

  Future<List<PrecosModelResponse>> buscarPlanos() async {
    try {
      final response = await restClient.unauth.get("/preco/find");
      return response.data
          .map<PrecosModelResponse>((e) => PrecosModelResponse.fromMap(e))
          .toList();
    } catch (e, s) {
      log('Erro ao buscar preço', error: e, stackTrace: s);
      throw CreateException.dioException(e);
    }
  }

  Future<PixResponse> gerarPix(PixRequest body) async {
    try {
      final response = await restClient.unauth.post(
        "/plano/pix",
        data: body.toJson(),
      );
      return PixResponse.fromMap(response.data);
    } catch (e, s) {
      log('Erro ao gerar PIX', error: e, stackTrace: s);
      throw CreateException.dioException(e);
    }
  }

  Future<String> verificarStatusPagamento(int paymentId) async {
    try {
      final response = await restClient.unauth.get(
        "/plano/pix-status",
        queryParameters: {'paymentId': paymentId},
      );
      return response.data['status'] ?? "";
    } catch (e, s) {
      log('Erro ao verificar status do pagamento', error: e, stackTrace: s);
      throw CreateException.dioException(e);
    }
  }

  Future<String> buscaPublicKey() async {
    try {
      final response = await restClient.unauth.get("/plano/public-key");
      return response.data['publicKey'] ?? "";
    } catch (e, s) {
      log('Erro ao buscar public key', error: e, stackTrace: s);
      throw CreateException.dioException(e);
    }
  }

  Future<CardResponse> pagamentoCard(CardRequest body) async {
    try {
      final response = await restClient.unauth.post(
        "/plano/card",
        data: body.toJson(),
      );
      return CardResponse.fromMap(response.data);
    } catch (e, s) {
      log('Erro ao realizar pagamento', error: e, stackTrace: s);
      throw CreateException.dioException(e);
    }
  }

  Future<CardStatusResponse> statusCard(int paymentId) async {
    try {
      final response = await restClient.unauth.get("/plano/card-status");
      return CardStatusResponse.fromMap(response.data);
    } catch (e, s) {
      log('Erro ao verificar status do pagamento', error: e, stackTrace: s);
      throw CreateException.dioException(e);
    }
  }
}
