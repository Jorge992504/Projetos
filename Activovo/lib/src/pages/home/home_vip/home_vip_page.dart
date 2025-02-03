import 'dart:developer';

import 'package:activovo/src/pages/home/home/home_state.dart';

import 'package:activovo/src/pages/home/home_vip/home_vip_vm.dart';
import 'package:activovo/src/pages/home/home_vip/widgets/home_header_vip.dart';

import 'package:activovo/src/ui/widgets/activovo_loader.dart';
import 'package:activovo/src/ui/widgets/exercicio_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeVipPage extends ConsumerWidget {
  const HomeVipPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final result = ref.watch(homeVipVmProvider);
    return Scaffold(
      body: result.when(
        data: (HomeState data) {
          return CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(
                child: HomeHeaderVip(),
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
              HomeHeaderVip(),
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
