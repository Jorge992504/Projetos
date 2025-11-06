// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:dente/core/exceptions/create_exception.dart';
import 'package:dente/core/rest_client/rest_client.dart';
import 'package:dente/src/models/response/historico_consultas_response.dart';

class HistoricoConsultasRepository {
  final RestClient restClient;
  HistoricoConsultasRepository({required this.restClient});

  Future<List<HistoricoConsultasResponse>> buscaHistoricoConsultas(
    int pacienteId,
  ) async {
    try {
      final response = await restClient.auth.get(
        "/agendamentos/busca/consultas-paciente",
        queryParameters: {"pacienteId": pacienteId},
      );
      return response.data
          .map<HistoricoConsultasResponse>(
            (e) => HistoricoConsultasResponse.fromMap(e),
          )
          .toList();
    } catch (e, s) {
      log('Erro ao buscar historico', error: e, stackTrace: s);
      throw CreateException.dioException(e);
    }
  }
}
