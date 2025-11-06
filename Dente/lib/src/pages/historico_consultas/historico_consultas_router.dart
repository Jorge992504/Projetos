import 'package:dente/src/pages/historico_consultas/historico_consultas_controller.dart';
import 'package:dente/src/pages/historico_consultas/historico_consultas_page.dart';
import 'package:dente/src/repository/historico_consultas_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoricoConsultasRouter {
  HistoricoConsultasRouter._();
  static Widget page() => MultiProvider(
    providers: [
      Provider<HistoricoConsultasRepository>(
        create: (context) =>
            HistoricoConsultasRepository(restClient: context.read()),
      ),
      Provider<HistoricoConsultasController>(
        create: (context) => HistoricoConsultasController(
          context.read<HistoricoConsultasRepository>(),
        ),
      ),
    ],
    child: const HistoricoConsultasPage(),
  );
}
