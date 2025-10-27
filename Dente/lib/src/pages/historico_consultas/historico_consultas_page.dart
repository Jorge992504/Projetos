import 'dart:developer';

import 'package:dente/core/ui/base/base_state.dart';
import 'package:dente/core/ui/style/size_extension.dart';
import 'package:dente/src/models/response/historico_consultas_response.dart';
import 'package:dente/src/pages/historico_consultas/historico_consultas_controller.dart';
import 'package:dente/src/pages/historico_consultas/historico_consultas_state.dart';
import 'package:dente/src/pages/historico_consultas/widgets/card_historico_consultas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class HistoricoConsultasPage extends StatefulWidget {
  const HistoricoConsultasPage({super.key});

  @override
  State<HistoricoConsultasPage> createState() => _HistoricoConsultasPageState();
}

class _HistoricoConsultasPageState
    extends BaseState<HistoricoConsultasPage, HistoricoConsultasController> {
  int pacienteId = 0;
  List<HistoricoConsultasResponse> consultas = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final route = ModalRoute.of(context);
      final arguments =
          (route!.settings.arguments ?? <String, dynamic>{}) as Map;
      setState(() {
        pacienteId = arguments['agendamentoDetalhe'];
      });
      consultas = await controller.buscaHistoricoConsultas(pacienteId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Historico de consultas')),
      body: BlocConsumer<HistoricoConsultasController, HistoricoConsultasState>(
        listener: (context, state) {
          state.status.matchAny(
            any: hideLoader,
            loading: showLoader,
            loaded: hideLoader,
            failure: () {
              showError(state.errorMessage ?? 'INTERNAL_ERROR');

              hideLoader();
            },
            success: () async {
              // showSuccess("Sucesso ao realizar cadastro.");
              // Navigator.of(context).pop();
              hideLoader();
            },
          );
        },
        builder: (context, state) {
          return LayoutBuilder(
            builder: (context, tamanho) {
              return Align(
                alignment: Alignment.center,
                child: Container(
                  width: 1000,
                  height: context.percentHeight(1),
                  padding: EdgeInsets.only(top: 20, left: 25, right: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: consultas.length,
                          itemBuilder: (context, index) {
                            HistoricoConsultasResponse consultasDetalhe =
                                consultas[index];
                            String dataCompleta =
                                consultasDetalhe.dataHora ?? "";
                            String dataSomente = dataCompleta.split(' - ')[0];
                            return CardHistoricoConsultas(
                              nome: consultasDetalhe.nomePaciente,
                              servico: consultasDetalhe.servico,
                              horario: dataSomente,
                              status: consultasDetalhe.status,
                              atedimento: consultasDetalhe.atendimento,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
