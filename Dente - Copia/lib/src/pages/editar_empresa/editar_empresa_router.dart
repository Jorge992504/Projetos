import 'package:dente/src/pages/editar_empresa/editar_empresa_controller.dart';
import 'package:dente/src/pages/editar_empresa/editar_empresa_page.dart';
import 'package:dente/src/repository/editar_empresa_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditarEmpresaRouter {
  EditarEmpresaRouter._();
  static Widget page() => MultiProvider(
    providers: [
      Provider<EditarEmpresaRepository>(
        create: (context) =>
            EditarEmpresaRepository(restClient: context.read()),
      ),
      Provider<EditarEmpresaController>(
        create: (context) =>
            EditarEmpresaController(context.read<EditarEmpresaRepository>()),
      ),
    ],
    child: const EditarEmpresaPage(),
  );
}
