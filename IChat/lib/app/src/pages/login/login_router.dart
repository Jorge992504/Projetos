import 'package:flutter/material.dart';
import 'package:ichat/app/src/pages/login/login_controller.dart';
import 'package:ichat/app/src/pages/login/login_page.dart';
import 'package:ichat/app/src/providers/auth_provider.dart';
import 'package:ichat/app/src/repository/login_repository.dart';
import 'package:provider/provider.dart';

class LoginRouter {
  LoginRouter._();
  static Widget page() => MultiProvider(
    providers: [
      Provider<LoginRepository>(
        create: (context) => LoginRepository(restClient: context.read()),
      ),
      Provider<LoginController>(
        create: (context) => LoginController(context.read<AuthProvider>()),
      ),
    ],
    child: const LoginPage(),
  );
}
