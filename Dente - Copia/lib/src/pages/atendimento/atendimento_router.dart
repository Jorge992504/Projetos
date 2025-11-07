import 'package:dente/src/pages/atendimento/atendimento_controller.dart';
import 'package:dente/src/pages/atendimento/atendimento_page.dart';
import 'package:dente/src/repository/atendimento_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AtendimentoRouter {
  AtendimentoRouter._();
  static Widget page() => MultiProvider(
    providers: [
      Provider<AtendimentoRepository>(
        create: (context) => AtendimentoRepository(restClient: context.read()),
      ),
      Provider<AtendimentoController>(
        create: (context) =>
            AtendimentoController(context.read<AtendimentoRepository>()),
      ),
    ],
    child: const AtendimentoPage(),
  );
}
