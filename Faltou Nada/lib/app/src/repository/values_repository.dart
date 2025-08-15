import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:faltou_nada/app/core/exceptions/create_exception.dart';
import 'package:faltou_nada/app/core/rest_client/rest_client.dart';

class ValuesRepository {
  final RestClient restClient;
  ValuesRepository({
    required this.restClient,
  });

  Future<void> enviarPdf(FormData formData) async {
    try {
      await restClient.auth.post("/nfe", queryParameters: {
        'arquivo': formData,
      });
    } catch (e, s) {
      log('Erro ao enviar PDF', error: e, stackTrace: s);
      throw CreateException.dioException(e, 'Erro ao enviar PDF');
    }
  }
}
