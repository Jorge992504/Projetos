// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:dente/core/exceptions/create_exception.dart';
import 'package:dente/core/rest_client/rest_client.dart';
import 'package:dio/dio.dart';

class AtendimentoRepository {
  final RestClient restClient;
  AtendimentoRepository({required this.restClient});

  Future<void> terminarAtendimento(FormData formData) async {
    try {
      await restClient.auth.post(
        "/atendimento/finalizar",
        data: formData,
        options: Options(headers: {'Content-Type': 'multipart/form-data'}),
      );
    } catch (e, s) {
      log('Erro ao salvar arquivos', error: e, stackTrace: s);
      throw CreateException.dioException(e);
    }
  }
}
