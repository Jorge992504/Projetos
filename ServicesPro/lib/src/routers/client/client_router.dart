import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:servicespro/src/controllers/client/cliente_controller.dart';
import 'package:servicespro/src/pages/client_pages/client_principal_screem.dart';
import 'package:servicespro/src/repository/client/client_repository.dart';

class ClientRouter {
  ClientRouter._();
  static Widget page() => MultiProvider(
    providers: [
      Provider<ClientRepository>(
        create: (context) => ClientRepository(restClient: context.read()),
      ),
      Provider<ClienteController>(
        create: (context) =>
            ClienteController(context.read<ClientRepository>()),
      ),
    ],
    child: ClientPrincipalScreen(),
  );
}
