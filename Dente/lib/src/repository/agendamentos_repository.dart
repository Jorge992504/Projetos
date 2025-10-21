// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:dente/core/exceptions/create_exception.dart';
import 'package:dente/core/rest_client/rest_client.dart';
import 'package:dente/src/models/request/novo_agendamento_model_request.dart';
import 'package:dente/src/models/response/busca_servicos_dentistas_agendamento_response.dart';

class AgendamentosRepository {
  final RestClient restClient;
  AgendamentosRepository({required this.restClient});

  Future<BuscaServicosDentistasAgendamentoResponse>
  buscaDentistasServicos() async {
    try {
      final response = await restClient.auth.get(
        "/agendamentos/busca/dentistas-servicos",
      );
      return BuscaServicosDentistasAgendamentoResponse.fromMap(response.data);
    } catch (e, s) {
      log('Erro ao buscar dados', error: e, stackTrace: s);
      throw CreateException.dioException(e);
    }
  }

  Future<void> criaNovoAgendamento(NovoAgendamentoModelRequest body) async {
    try {
      await restClient.auth.post("/agendamentos/novo", data: body.toJson());
    } catch (e, s) {
      log('Erro ao salvar agendamento', error: e, stackTrace: s);
      throw CreateException.dioException(e);
    }
  }
}
