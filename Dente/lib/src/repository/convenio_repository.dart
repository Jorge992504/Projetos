// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:dente/core/exceptions/create_exception.dart';
import 'package:dente/core/rest_client/rest_client.dart';
import 'package:dente/src/models/convenio_model.dart';
import 'package:dente/src/models/response/busca_servicos_dentistas_agendamento_response.dart';
import 'package:dente/src/models/response/listar_convenios_response.dart';

class ConvenioRepository {
  final RestClient restClient;
  ConvenioRepository({required this.restClient});

  Future<List<ListarConveniosResponse>> buscaConvenios() async {
    try {
      final response = await restClient.auth.get("/convenio/buscar");
      return response.data
          .map<ListarConveniosResponse>(
            (e) => ListarConveniosResponse.fromMap(e),
          )
          .toList();
    } catch (e, s) {
      log('Erro ao buscar dados', error: e, stackTrace: s);
      throw CreateException.dioException(e);
    }
  }

  Future<void> incluirConvenios(ConvenioModel convenioModel) async {
    try {
      await restClient.auth.post(
        "/convenio/incluir",
        data: convenioModel.toJson(),
      );
    } catch (e, s) {
      log('Erro ao incluir dados', error: e, stackTrace: s);
      throw CreateException.dioException(e);
    }
  }

  Future<List<BuscaServicosAgendamentoResponse>> buscaServicos() async {
    try {
      final response = await restClient.auth.get("/convenio/busca/servicos");
      return response.data
          .map<BuscaServicosAgendamentoResponse>(
            (e) => BuscaServicosAgendamentoResponse.fromMap(e),
          )
          .toList();
    } catch (e, s) {
      log('Erro ao buscar dados', error: e, stackTrace: s);
      throw CreateException.dioException(e);
    }
  }
}
