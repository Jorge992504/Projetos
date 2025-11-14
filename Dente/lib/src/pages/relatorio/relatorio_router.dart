import 'package:dente/src/pages/relatorio/relatorio_controller.dart';
import 'package:dente/src/pages/relatorio/relatorio_page.dart';
import 'package:dente/src/repository/relatorio_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RelatorioRouter {
  RelatorioRouter._();
  static Widget page() => MultiProvider(
    providers: [
      Provider<RelatorioRepository>(
        create: (context) => RelatorioRepository(restClient: context.read()),
      ),
      Provider<RelatorioController>(
        create: (context) =>
            RelatorioController(context.read<RelatorioRepository>()),
      ),
    ],
    child: const RelatorioPage(),
  );
}
