import 'dart:developer';

import 'package:activovo/src/pages/training/treinos_com_doenca/treino_com_doencas_state.dart';
import 'package:activovo/src/pages/training/treinos_com_doenca/treino_com_doencas_vm.dart';
import 'package:activovo/src/pages/training/treinos_com_doenca/treino_function/treino_function_state.dart';
import 'package:activovo/src/pages/training/treinos_com_doenca/treino_function/treino_function_vm.dart';

import 'package:activovo/src/rotas/rotas.dart';
import 'package:activovo/src/ui/colors/colors_constants.dart';
import 'package:activovo/src/ui/helpers/messages.dart';
import 'package:activovo/src/ui/widgets/activovo_loader.dart';
import 'package:activovo/src/ui/widgets/check_doencas.dart';
import 'package:activovo/src/ui/widgets/week_days_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserComDoencas extends ConsumerWidget {
  const UserComDoencas({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final result = ref.watch(treinoComDoencasVmProvider);
    final treinoFunction = ref.watch(treinoFunctionVmProvider.notifier);
    final formKey = GlobalKey<FormState>();
    ref.listen(treinoFunctionVmProvider, (_, state) {
      switch (state.status) {
        case TreinoFunctionStateStatus.initial:
          break;
        case TreinoFunctionStateStatus.error:
          Messages.showError('Erro ao registrar treino com doenças', context);
        case TreinoFunctionStateStatus.success:
          Navigator.of(context)
              .pushNamedAndRemoveUntil(Rotas.home, (routes) => false);
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          ImageConstante.titulo,
          width: 130,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 24,
                ),
                WeekDaysPanel(
                  onDaysPressed: (value) {
                    treinoFunction.addOrRemoveDays(value);
                  },
                ),
                const SizedBox(
                  height: 24,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Selecione as doençãs',
                        style: context.fontes.textExtraBold.copyWith(
                          fontSize: 18,
                          color: ColorsConstants.greyTitulos,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        width: context.WidthScreenM(1),
                        height: context.HeightScreenM(0.4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: ColorsConstants.greyEntryF,
                          border: Border.all(
                            color: ColorsConstants.greyEntryF,
                          ),
                        ),
                        child: result.whenOrNull(
                          data: (TreinoComDoencasState data) {
                            return CustomScrollView(
                              slivers: [
                                SliverList(
                                  delegate: SliverChildBuilderDelegate(
                                    (context, index) => CheckDoencas(
                                      diseaseModel: data.doencas[index],
                                      onPresses: (value) {
                                        treinoFunction
                                            .addOrRemoveDisease(value.id);
                                      },
                                    ),
                                    childCount: data.doencas.length,
                                  ),
                                ),
                              ],
                            );
                          },
                          error: (error, s) {
                            log('Erro ao buscar doenças',
                                error: error, stackTrace: s);
                            return const Center(
                              child: Text('Error ao buscar doenças'),
                            );
                          },
                          loading: () {
                            return const ActivovoLoader();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        final result = treinoFunction.validar();
                        switch (result) {
                          case false:
                            Messages.showError(
                                'Os campos não podem estar sem selecionar',
                                context);
                          case true:
                            treinoFunction.registerTreino();
                        }
                      },
                      child: Text(
                        'Continuar',
                        style: context.fontes.textBold.copyWith(
                            color: ColorsConstants.greyBotoes, fontSize: 16),
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_rounded,
                      size: 20,
                      color: ColorsConstants.greyBotoes,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
// WeekDaysPanel

