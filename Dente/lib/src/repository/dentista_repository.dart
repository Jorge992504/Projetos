// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:dente/core/exceptions/create_exception.dart';
import 'package:dente/core/rest_client/rest_client.dart';
import 'package:dente/src/models/dentista_model.dart';

class DentistaRepository {
  final RestClient restClient;
  DentistaRepository({required this.restClient});

  Future<void> registrarDentista(DentistaModel dentistaModel) async {
    try {
      await restClient.auth.post(
        "/dentista/registrar",
        data: dentistaModel.toJson(),
      );
    } catch (e, s) {
      log('Erro ao registrar dentista', error: e, stackTrace: s);
      throw CreateException.dioException(e);
    }
  }

  Future<List<DentistaModel>> buscarDentistas() async {
    try {
      final response = await restClient.auth.get("/dentista/buscar");
      return response.data
          .map<DentistaModel>((e) => DentistaModel.fromMap(e))
          .toList();
    } catch (e, s) {
      log('Erro ao buscar dentistas', error: e, stackTrace: s);
      throw CreateException.dioException(e);
    }
  }

  Future<void> inativarDentistas(DentistaModel dentistaModel) async {
    try {
      await restClient.auth.post(
        "/dentista/inativar",
        data: dentistaModel.toJson(),
      );
    } catch (e, s) {
      log('Erro ao inativar dentista', error: e, stackTrace: s);
      throw CreateException.dioException(e);
    }
  }
}
