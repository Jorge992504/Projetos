import 'dart:developer';

import 'package:activovo/src/pages/home/home/home_state.dart';
import 'package:activovo/src/pages/home/home/home_vm.dart';
import 'package:activovo/src/pages/home/home/widgets/home_header.dart';

import 'package:activovo/src/ui/widgets/activovo_loader.dart';

import 'package:activovo/src/ui/widgets/exercicio_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final result = ref.watch(homeVmProvider);
    return Scaffold(
      body: result.when(
        data: (HomeState data) {
          return CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(
                child: HomeHeader(),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => ExercicioHome(
                    label: data.exercise[index],
                  ),
                  childCount: data.exercise.length,
                ),
              ),
            ],
          );
        },
        error: (error, s) {
          log('Não tem treino para hoje', error: error, stackTrace: s);
          return const Column(
            children: [
              HomeHeader(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Não tem treino para hoje'),
                ],
              ),
            ],
          );
        },
        loading: () {
          return const ActivovoLoader();
        },
      ),
    );
  }
}
