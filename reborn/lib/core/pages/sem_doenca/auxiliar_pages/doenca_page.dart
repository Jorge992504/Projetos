import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:reborn/core/componentes/componentes_exercicios_page/check_box_exercicios.dart';

import 'package:reborn/core/pages/doenca/doenca_controller.dart';
import 'package:reborn/core/pages/doenca/doenca_state.dart';
import 'package:reborn/core/ui/base_state.dart';
import 'package:reborn/core/detalhes_telas/size_tela/size.dart';
// import 'package:reborn/core/detalhes_telas/text/text_estilo.dart';

class DoencasPage extends StatefulWidget {
  const DoencasPage({
    super.key,
  });

  @override
  State<DoencasPage> createState() => _DoencasPage();
}

class _DoencasPage extends BaseState<DoencasPage, DoencaController> {
  bool visibleDias = true;
  Timer? _timer;
  final formKey = GlobalKey<FormState>();
  bool isCheck = false;
  bool isEnabled = true;

  final dias = TextEditingController();

  @override
  void dispose() {
    _timer?.cancel(); // Cancela o timer
    super.dispose();
  }

  @override
  void onReady() {
    controller.listarDoencas();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DoencaController, DoencaState>(
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
            showSuccess('Doenças cargadas com sucesso');
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
                              itemCount: state.doenca.length,
                              itemBuilder: (context, index) {
                                final doenca = state.doenca[index];
                                return CheckBoxExercicios(
                                  isCheck: isCheck,
                                  salvarExercicio: controller.selecionarDoenca,
                                  doenca: doenca,
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
            BlocConsumer<DoencaController, DoencaState>(
              listener: (context, state) {
                state.status.match(
                  initial: () {},
                  loading: () {},
                  loaded: () {},
                  register: () => showLoader(),
                  error: () {
                    hideLoader();
                    showError('Erro ao relacionar as doenças');
                  },
                  success: () {
                    hideLoader();
                    showSuccess('Doenças relacionadas com successo');
                  },
                );
              },
              buildWhen: (previous, current) => current.status.matchAny(
                any: () => false,
                initial: () => true,
                loaded: () => true,
              ),
              builder: (context, state) {
                return Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    margin:
                        const EdgeInsets.only(right: 67, bottom: 30, left: 67),
                    child: SizedBox(
                      width: context.screenMetadeLargura(1),
                      child: ElevatedButton(
                        onPressed: () {
                          controller.relacionarUsuarioDoenca();
                        },
                        child: const Icon(
                          Icons.save_alt,
                          color: Colors.green,
                        ),
                      ),
                    ),
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
