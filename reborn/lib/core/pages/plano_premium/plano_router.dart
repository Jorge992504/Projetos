import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reborn/core/implementacoes_interfaz/plano_repository_impl.dart';
import 'package:reborn/core/pages/plano_premium/plano_controller.dart';
import 'package:reborn/core/pages/plano_premium/plano_premium_page.dart';
import 'package:reborn/core/repositorio/plano_repository.dart';

class PlanoRouter {
  PlanoRouter._();
  static Widget get page => MultiProvider(
        providers: [
          Provider<PlanoRepository>(
            create: (context) => PlanoRepositoryImpl(
              dio: context.read(),
            ),
          ),
          Provider(
            create: (context) => PlanoController(
              context.read(),
            ),
          ),
        ],
        child: const PlanoPremiumPage(),
      );
}
