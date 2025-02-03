import 'package:activovo/src/pages/training/treino_sem_doenca/treino_sem_doencas_state.dart';
import 'package:activovo/src/pages/training/treino_sem_doenca/treino_sem_doencas_vm.dart';
import 'package:activovo/src/rotas/rotas.dart';

import 'package:activovo/src/ui/colors/colors_constants.dart';
import 'package:activovo/src/ui/helpers/messages.dart';
import 'package:activovo/src/ui/widgets/week_days_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserSemDoencas extends ConsumerStatefulWidget {
  const UserSemDoencas({super.key});

  @override
  ConsumerState<UserSemDoencas> createState() => _UserSemDoencasState();
}

class _UserSemDoencasState extends ConsumerState<UserSemDoencas> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final treinoSemDoencasVm = ref.watch(treinoSemDoencasVmProvider.notifier);
    ref.listen(treinoSemDoencasVmProvider, (_, state) {
      switch (state.status) {
        case TreinoSemDoencasStateStatus.initial:
          break;
        case TreinoSemDoencasStateStatus.error:
          Messages.showError('Erro ao registrar treino sem doenças', context);
        case TreinoSemDoencasStateStatus.success:
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 94,
                ),
                WeekDaysPanel(
                  onDaysPressed: (value) {
                    treinoSemDoencasVm.addOrRemoveDays(value);
                  },
                ),
                const SizedBox(
                  height: 200,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        final result = treinoSemDoencasVm.validar();
                        switch (result) {
                          case false:
                            Messages.showError(
                                'Selecione os dias para treinar', context);
                          case true:
                            treinoSemDoencasVm.registarTreino();
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
