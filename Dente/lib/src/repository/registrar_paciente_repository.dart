// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:dente/core/exceptions/create_exception.dart';
import 'package:dente/core/rest_client/rest_client.dart';
import 'package:dente/src/models/paciente_model.dart';

class RegistrarPacienteRepository {
  final RestClient restClient;
  RegistrarPacienteRepository({required this.restClient});

  Future<void> registrarPaciente(PacienteModel pacienteModel) async {
    try {
      await restClient.auth.post(
        "/paciente/registrar",
        data: pacienteModel.toJson(),
      );
    } catch (e, s) {
      log('Erro ao registrar paciente', error: e, stackTrace: s);
      throw CreateException.dioException(e);
    }
  }

  Future<List<PacienteModel>> buscarPacientes() async {
    try {
      final response = await restClient.auth.get("/paciente/buscar");
      return response.data
          .map<PacienteModel>((p) => PacienteModel.fromMap(p))
          .toList();
    } catch (e, s) {
      log('Erro ao buscar os pacientes', error: e, stackTrace: s);
      throw CreateException.dioException(e);
    }
  }
}
