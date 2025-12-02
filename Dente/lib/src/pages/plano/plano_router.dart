import 'package:dente/src/pages/plano/plano_controller.dart';
import 'package:dente/src/pages/plano/plano_page.dart';
import 'package:dente/src/repository/plano_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlanoRouter {
  PlanoRouter._();
  static Widget page() => MultiProvider(
    providers: [
      Provider<PlanoRepository>(
        create: (context) => PlanoRepository(restClient: context.read()),
      ),
      Provider<PlanoController>(
        create: (context) => PlanoController(context.read<PlanoRepository>()),
      ),
    ],
    child: const PlanoPage(),
  );
}
