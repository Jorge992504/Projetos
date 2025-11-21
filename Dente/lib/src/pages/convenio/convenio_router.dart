import 'package:dente/src/pages/convenio/convenio_controller.dart';
import 'package:dente/src/pages/convenio/convenio_page.dart';
import 'package:dente/src/repository/convenio_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConvenioRouter {
  ConvenioRouter._();
  static Widget page() => MultiProvider(
    providers: [
      Provider<ConvenioRepository>(
        create: (context) => ConvenioRepository(restClient: context.read()),
      ),
      Provider<ConvenioController>(
        create: (context) =>
            ConvenioController(context.read<ConvenioRepository>()),
      ),
    ],
    child: const ConvenioPage(),
  );
}
