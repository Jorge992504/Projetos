import 'package:dente/src/pages/registrar_empresa/registrar_empresa_controller.dart';
import 'package:dente/src/pages/registrar_empresa/registrar_empresa_page.dart';
import 'package:dente/src/repository/registrar_empresa_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegistrarEmpresaRouter {
  RegistrarEmpresaRouter._();
  static Widget page() => MultiProvider(
    providers: [
      Provider<RegistrarEmpresaRepository>(
        create: (context) =>
            RegistrarEmpresaRepository(restClient: context.read()),
      ),
      Provider<RegistrarEmpresaController>(
        create: (context) => RegistrarEmpresaController(
          context.read<RegistrarEmpresaRepository>(),
        ),
      ),
    ],
    child: const RegistrarEmpresaPage(),
  );
}
