import 'package:faltou_nada/app/src/pages/login/login_controller.dart';
import 'package:faltou_nada/app/src/pages/login/login_page.dart';
import 'package:faltou_nada/app/src/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginRouter {
  LoginRouter._();
  static Widget page() => MultiProvider(
        providers: [
          Provider<AuthRepository>(
            create: (context) => AuthRepository(
              restClient: context.read(),
            ),
          ),
          Provider<LoginController>(
            create: (context) => LoginController(
              context.read<AuthRepository>(),
            ),
          ),
        ],
        child: const LoginPage(),
      );
}
