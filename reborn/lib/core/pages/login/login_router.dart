import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reborn/core/pages/login/login_controller.dart';
import 'package:reborn/core/pages/login/login_page.dart';
import 'package:reborn/core/providers/auth_provider.dart';
import 'package:reborn/core/repositorio/login_repositorio.dart';
//import 'package:reborn/core/providers/auth_provider.dart';

class LoginRouter {
  LoginRouter._();

  static Widget get page => MultiProvider(
        providers: [
          Provider(
            create: (context) => LoginController(
                context.read<LoginRepository>(), context.read<AuthProvider>()),
          )
        ],
        child: const LoginPage(),
      );
}
