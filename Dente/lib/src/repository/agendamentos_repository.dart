// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:dente/core/exceptions/create_exception.dart';
import 'package:dente/core/rest_client/rest_client.dart';

class AgendamentosRepository {
  final RestClient restClient;
  AgendamentosRepository({required this.restClient});

  Future<void> buscaClientesPorCPF() async {
    try {
      await restClient.auth.get("/agendamentos/busca/clientes");
    } catch (e, s) {
      log('Erro ao buscar os clientes', error: e, stackTrace: s);
      throw CreateException.dioException(e);
    }
  }
}
