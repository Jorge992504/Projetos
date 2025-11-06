import 'package:dente/src/pages/agendamento/agendamento_controller.dart';
import 'package:dente/src/pages/agendamento/agendamento_page.dart';
import 'package:dente/src/repository/agendamentos_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AgendamentoRouter {
  AgendamentoRouter._();
  static Widget page() => MultiProvider(
    providers: [
      Provider<AgendamentosRepository>(
        create: (context) => AgendamentosRepository(restClient: context.read()),
      ),
      Provider<AgendamentoController>(
        create: (context) =>
            AgendamentoController(context.read<AgendamentosRepository>()),
      ),
    ],
    child: const AgendamentoPage(),
  );
}
