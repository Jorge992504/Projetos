import 'package:faltou_nada/app/src/pages/register/register_controller.dart';
import 'package:faltou_nada/app/src/pages/register/register_page.dart';
import 'package:faltou_nada/app/src/repository/register_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterRouter {
  RegisterRouter._();
  static Widget page() => MultiProvider(
    providers: [
      Provider<RegisterRepository>(
        create: (context) => RegisterRepository(restClient: context.read()),
      ),
      Provider<RegisterController>(
        create: (context) =>
            RegisterController(context.read<RegisterRepository>()),
      ),
    ],
    child: const RegisterPage(),
  );
}
