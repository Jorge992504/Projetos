// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:dente/core/exceptions/create_exception.dart';
import 'package:dente/core/rest_client/rest_client.dart';
import 'package:dente/src/models/response/historico_arquivos_response.dart';

class HistoricoPacienteRepository {
  final RestClient restClient;
  HistoricoPacienteRepository({required this.restClient});

  Future<List<HistoricoArquivosResponse>> buscaHistoricoPaciente(
    int pacienteId,
  ) async {
    try {
      final response = await restClient.auth.get(
        "/paciente/busca-historico",
        queryParameters: {"pacienteId": pacienteId},
      );
      return response.data
          .map<HistoricoArquivosResponse>(
            (e) => HistoricoArquivosResponse.fromMap(e),
          )
          .toList();
    } catch (e, s) {
      log('Erro ao buscar historico', error: e, stackTrace: s);
      throw CreateException.dioException(e);
    }
  }
}
