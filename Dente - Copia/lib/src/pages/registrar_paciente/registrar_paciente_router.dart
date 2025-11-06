import 'package:dente/src/pages/registrar_paciente/registrar_paciente_controller.dart';
import 'package:dente/src/pages/registrar_paciente/registrar_paciente_page.dart';
import 'package:dente/src/repository/registrar_paciente_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegistrarPacienteRouter {
  RegistrarPacienteRouter._();
  static Widget page() => MultiProvider(
    providers: [
      Provider<RegistrarPacienteRepository>(
        create: (context) =>
            RegistrarPacienteRepository(restClient: context.read()),
      ),
      Provider<RegistrarPacienteController>(
        create: (context) => RegistrarPacienteController(
          context.read<RegistrarPacienteRepository>(),
        ),
      ),
    ],
    child: const RegistrarPacientePage(),
  );
}
