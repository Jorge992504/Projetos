import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reborn/core/custom_dio/custom_dio.dart';
import 'package:reborn/core/implementacoes_interfaz/dias_treino_repository_impl.dart';
import 'package:reborn/core/pages/dias_treino/auxilia_pages/treino_page.dart';
import 'package:reborn/core/pages/dias_treino/dias_treino_controller.dart';
import 'package:reborn/core/repositorio/dias_treino_repository.dart';

class DiasTreinoRouter {
  DiasTreinoRouter._();
  static Widget get page => MultiProvider(
        providers: [
          Provider<DiasTreinoRepository>(
            create: (context) => DiasTreinoRepositoryImpl(
              dio: context.read<CustomDio>(),
            ),
          ),
          Provider<DiasTreinoController>(
            create: (context) => DiasTreinoController(
              context.read<DiasTreinoRepository>(),
            ),
          ),
        ],
        child: const DiasTreinoPage(),
      );
}
