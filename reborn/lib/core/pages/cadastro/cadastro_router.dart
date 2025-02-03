import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reborn/core/custom_dio/custom_dio.dart';
import 'package:reborn/core/implementacoes_interfaz/auth_cadastro_impl.dart';
import 'package:reborn/core/pages/cadastro/cadastro_controller.dart';
import 'package:reborn/core/pages/cadastro/cadastro_page.dart';
import 'package:reborn/core/providers/auth_provider.dart';

import 'package:reborn/core/repositorio/cadastro_repositorio.dart';
import 'package:reborn/core/repositorio/login_repositorio.dart';

class CadastroRouter {
  CadastroRouter._();

  static Widget get page => MultiProvider(
        providers: [
          Provider<CadastroRepository>(
            create: (context) => AuthCadastroImpl(
              dio: context.read<CustomDio>(),
            ),
          ),
          Provider<CadastrarController>(
            create: (context) => CadastrarController(
              context.read<CadastroRepository>(),
              context.read<LoginRepository>(),
              context.read<AuthProvider>(),
            ),
          ),
        ],
        child: const CadastroPage(),
      );
}
