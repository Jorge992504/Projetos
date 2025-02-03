import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reborn/core/custom_dio/custom_dio.dart';
import 'package:reborn/core/implementacoes_interfaz/dias_treino_repository_impl.dart';
import 'package:reborn/core/implementacoes_interfaz/doenca_repository_impl.dart';
import 'package:reborn/core/implementacoes_interfaz/treino_repository_impl.dart';
import 'package:reborn/core/pages/dias_treino/dias_treino_controller.dart';
import 'package:reborn/core/pages/doenca/doenca_controller.dart';
import 'package:reborn/core/pages/doenca/doenca_page.dart';
import 'package:reborn/core/pages/sem_doenca/doenca_page.dart';
import 'package:reborn/core/pages/treino/treino_controller.dart';
import 'package:reborn/core/repositorio/dias_treino_repository.dart';

import 'package:reborn/core/repositorio/doenca_repository.dart';

class SemDoencaRouter {
  SemDoencaRouter._();
  static Widget get page => MultiProvider(
        providers: [
          Provider<DoencaRepository>(
            create: (context) => DoencaRepositoryImpl(
              dio: context.read<CustomDio>(),
            ),
          ),
          Provider<DiasTreinoRepository>(
            create: (context) => DiasTreinoRepositoryImpl(
              dio: context.read<CustomDio>(),
            ),
          ),
          Provider<TreinoRepositoryImpl>(
            create: (context) => TreinoRepositoryImpl(
              dio: context.read<CustomDio>(),
            ),
          ),
          Provider<DoencaController>(
            create: (context) => DoencaController(
              context.read<DoencaRepository>(),
            ),
          ),
          Provider<DiasTreinoController>(
            create: (context) => DiasTreinoController(
              context.read<DiasTreinoRepository>(),
            ),
          ),
          Provider<TreinoController>(
            create: (context) => TreinoController(
              context.read<TreinoRepositoryImpl>(),
            ),
          ),
        ],
        child: const SemDoencaPage(),
      );
}
