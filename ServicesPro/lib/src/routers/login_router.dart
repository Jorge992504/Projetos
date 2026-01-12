import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:servicespro/src/controllers/login_controller.dart';
import 'package:servicespro/src/pages/login_screen.dart';
import 'package:servicespro/src/repository/login_repository.dart';

class LoginRouter {
  LoginRouter._();
  static Widget page() => MultiProvider(
    providers: [
      Provider<LoginRepository>(
        create: (context) => LoginRepository(restClient: context.read()),
      ),
      Provider<LoginController>(
        create: (context) => LoginController(context.read<LoginRepository>()),
      ),
    ],
    child: const LoginScreen(),
  );
}
