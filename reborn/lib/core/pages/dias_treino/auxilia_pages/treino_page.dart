import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reborn/core/componentes/componentes_exercicios_page/check_box_dias_treino.dart';

import 'package:reborn/core/detalhes_telas/size_tela/size.dart';
import 'package:reborn/core/detalhes_telas/text/text_estilo.dart';

import 'package:reborn/core/pages/dias_treino/dias_treino_controller.dart';
import 'package:reborn/core/pages/dias_treino/dias_treino_state.dart';

import 'package:reborn/core/ui/base_state.dart';

class DiasTreinoPage extends StatefulWidget {
  const DiasTreinoPage({
    super.key,
  });

  @override
  State<DiasTreinoPage> createState() => _DiasTreinoPage();
}

class _DiasTreinoPage extends BaseState<DiasTreinoPage, DiasTreinoController> {
  final formKey = GlobalKey<FormState>();
  bool isCheck = false;
  bool isEnabled = true;

  final dias = TextEditingController();

  @override
  void onReady() {
    // controller.loadExercicios();
    controller.listarDiasTreinos();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DiasTreinoController, DiasTreinoState>(
      listener: (context, state) {
        state.status.matchAny(
          any: () => hideLoader(),
          loading: () => showLoader,
          error: () {
            hideLoader();
            showError('Sem conexão');
          },
          success: () {
            hideLoader();
            showSuccess('Dias cargados com sucesso');
          },
        );
      },
      buildWhen: (previous, current) => current.status.matchAny(
        any: () => false,
        initial: () => true,
        loaded: () => true,
      ),
      builder: (context, state) {
        return Stack(
          children: [
            Container(
              alignment: Alignment.topCenter,
              margin: const EdgeInsets.only(
                top: 30,
                left: 20,
                right: 20,
                bottom: 20,
              ),
              child: SizedBox(
                width: context.screenMetadeLargura(1),
                height: context.screenMetadeAltura(0.85),
                child: Card(
                  color: Colors.transparent,
                  child: Container(
                    alignment: Alignment.topCenter,
                    margin: const EdgeInsets.all(45),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 0.6,
                      ),
                    ),
                    child: SizedBox(
                      width: context.screenMetadeLargura(1),
                      height: context.screenMetadeAltura(0.85),
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              itemCount: state.dias.length,
                              itemBuilder: (context, index) {
                                final dias = state.dias[index];
                                return Stack(
                                  children: [
                                    const SizedBox(
                                      height: 60,
                                    ),
                                    CheckBoxDiasTreino(
                                      isCheck: isCheck,
                                      salvarDias:
                                          controller.selecionarDiasTreino,
                                      dias: dias,
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            BlocConsumer<DiasTreinoController, DiasTreinoState>(
              listener: (context, state) {
                state.status.match(
                  initial: () {},
                  loading: () {},
                  loaded: () {},
                  register: () => showLoader(),
                  error: () {
                    hideLoader();
                    showError('Erro ao relacionar o treino');
                  },
                  success: () {
                    hideLoader();
                    showSuccess('Dias relacionados com successo');
                  },
                );
              },
              buildWhen: (previous, current) => current.status.matchAny(
                any: () => false,
                initial: () => true,
                loaded: () => true,
              ),
              builder: (context, state) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    height: 40,
                    width: context.screenMetadeLargura(.95),
                    child: ElevatedButton(
                        onPressed: () {
                          controller.relacionarUsuarioDiasTreino();
                        },
                        // child: const Icon(Icons.delete_forever_sharp),
                        child: Text(
                          'Salvar os dias de treinamento',
                          style: context.textEstilo.textBold.copyWith(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        )),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
