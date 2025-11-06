import 'package:dente/src/pages/historico_paciente/historico_paciente_controller.dart';
import 'package:dente/src/pages/historico_paciente/historico_paciente_page.dart';
import 'package:dente/src/repository/historico_paciente_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoricoPacienteRouter {
  HistoricoPacienteRouter._();
  static Widget page() => MultiProvider(
    providers: [
      Provider<HistoricoPacienteRepository>(
        create: (context) =>
            HistoricoPacienteRepository(restClient: context.read()),
      ),
      Provider<HistoricoPacienteController>(
        create: (context) => HistoricoPacienteController(
          context.read<HistoricoPacienteRepository>(),
        ),
      ),
    ],
    child: const HistoricoPacientePage(),
  );
}
