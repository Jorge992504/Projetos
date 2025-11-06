import 'package:dente/src/pages/login/login_controller.dart';
import 'package:dente/src/pages/login/login_page.dart';
import 'package:dente/src/repository/login_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    child: const LoginPage(),
  );
}
