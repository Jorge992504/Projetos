// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:developer';

import 'package:dente/core/exceptions/create_exception.dart';
import 'package:dente/core/rest_client/rest_client.dart';
import 'package:dente/src/models/request/registrar_pagamento_request.dart';
import 'package:dente/src/models/response/buscar_convenios_pagamento_response.dart';

class PaymentRepository {
  final RestClient restClient;
  PaymentRepository({required this.restClient});

  Future<List<BuscarConveniosPagamentoResponse>>
  buscaDentistasServicos() async {
    try {
      final response = await restClient.auth.get("/pagamento/busca/convenios");
      return response.data
          .map<BuscarConveniosPagamentoResponse>(
            (e) => BuscarConveniosPagamentoResponse.fromMap(e),
          )
          .toList();
    } catch (e, s) {
      log('Erro ao buscar dados', error: e, stackTrace: s);
      throw CreateException.dioException(e);
    }
  }

  Future<void> terminarPagamento(RegistrarPagamentoRequest body) async {
    try {
      await restClient.auth.post(
        "/pagamento/grava/pagamento",
        data: body.toJson(),
      );
    } catch (e, s) {
      log('Erro ao registrar dados do pagamento', error: e, stackTrace: s);
      throw CreateException.dioException(e);
    }
  }
}
