import 'dart:developer';

import 'package:barber/src/core/ui/constant/color_constants.dart';
import 'package:barber/src/core/ui/widgets/barbershop_loader.dart';
import 'package:barber/src/features/home/adm/home_adm_state.dart';
import 'package:barber/src/features/home/adm/home_adm_vm.dart';
import 'package:barber/src/features/home/widgets/home_employee_tile.dart';
import 'package:barber/src/features/home/widgets/home_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeAdmPage extends ConsumerWidget {
  const HomeAdmPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeAdmVmProvider);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorConstants.brow,
        shape: const CircleBorder(),
        onPressed: () {},
        child: const CircleAvatar(
          backgroundColor: Colors.white,
          maxRadius: 12,
          child: Icon(
            Icons.add,
            color: ColorConstants.brow,
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: HomeHeader(),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => const HomeEmployeeTile(),
              childCount: 20,
            ),
          ),
        ],
      ),
    );
  }
}
