import 'package:dente/src/pages/servicos/servicos_controller.dart';
import 'package:dente/src/pages/servicos/servicos_page.dart';
import 'package:dente/src/repository/servicos_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ServicosRouter {
  ServicosRouter._();
  static Widget page() => MultiProvider(
    providers: [
      Provider<ServicosRepository>(
        create: (context) => ServicosRepository(restClient: context.read()),
      ),
      Provider<ServicosController>(
        create: (context) =>
            ServicosController(context.read<ServicosRepository>()),
      ),
    ],
    child: const ServicosPage(),
  );
}
