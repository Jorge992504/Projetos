import 'package:dente/src/pages/dentista/dentista_controller.dart';
import 'package:dente/src/pages/dentista/dentista_page.dart';
import 'package:dente/src/repository/dentista_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DentistaRouter {
  DentistaRouter._();
  static Widget page() => MultiProvider(
    providers: [
      Provider<DentistaRepository>(
        create: (context) => DentistaRepository(restClient: context.read()),
      ),
      Provider<DentistaController>(
        create: (context) =>
            DentistaController(context.read<DentistaRepository>()),
      ),
    ],
    child: const DentistaPage(),
  );
}
