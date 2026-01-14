import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:servicespro/src/controllers/register_controller.dart';
import 'package:servicespro/src/pages/register_screen.dart';
import 'package:servicespro/src/repository/register_repository.dart';

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
    child: const RegisterScreen(),
  );
}
