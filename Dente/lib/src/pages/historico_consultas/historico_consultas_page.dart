import 'package:dente/core/ui/base/base_state.dart';
import 'package:dente/core/ui/style/custom_colors.dart';
import 'package:dente/core/ui/style/fontes_letras.dart';
import 'package:dente/core/ui/style/size_extension.dart';
import 'package:dente/src/models/response/historico_consultas_response.dart';
import 'package:dente/src/pages/historico_consultas/historico_consultas_controller.dart';
import 'package:dente/src/pages/historico_consultas/historico_consultas_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons/lucide_icons.dart';

class HistoricoConsultasPage extends StatefulWidget {
  const HistoricoConsultasPage({super.key});

  @override
  State<HistoricoConsultasPage> createState() => _HistoricoConsultasPageState();
}

class _HistoricoConsultasPageState
    extends BaseState<HistoricoConsultasPage, HistoricoConsultasController> {
  int pacienteId = 0;
  String pacienteNm = '';
  List<HistoricoConsultasResponse> consultas = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final route = ModalRoute.of(context);
      final arguments =
          (route!.settings.arguments ?? <String, dynamic>{}) as Map;
      setState(() {
        pacienteId = arguments['pacienteId'];
        pacienteNm = arguments['pacienteNm'];
      });

      consultas = await controller.buscaHistoricoConsultas(pacienteId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Historico de consultas do paciente')),
      body: BlocConsumer<HistoricoConsultasController, HistoricoConsultasState>(
        listener: (context, state) {
          state.status.matchAny(
            any: hideLoader,
            loading: showLoader,
            loaded: hideLoader,
            failure: () {
              hideLoader();
              showError(state.errorMessage ?? 'INTERNAL_ERROR');
            },
            success: () {
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
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            Icon(
                              Icons.person_outline_outlined,
                              color: ColorsConstants.appBarColor,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              pacienteNm,
                              style: context.cusotomFontes.textBoldItalic
                                  .copyWith(
                                    color: ColorsConstants.appBarColor,
                                    fontSize: 18,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: consultas.length,
                          itemBuilder: (context, index) {
                            HistoricoConsultasResponse consultasDetalhe =
                                consultas[index];
                            String dataCompleta =
                                consultasDetalhe.dataHora ?? "";
                            String dataSomente = dataCompleta.split(' - ')[0];
                            // return CardHistoricoConsultas(

                            //   atedimento: consultasDetalhe.atendimento,
                            // );
                            return Container(
                              margin: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: ColorsConstants.primaryColor,
                                borderRadius: BorderRadius.circular(
                                  16,
                                ), // bordas circulares
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 4,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Theme(
                                  data: Theme.of(context).copyWith(
                                    dividerColor: Colors
                                        .transparent, // remove as linhas do ExpansionTile
                                  ),
                                  child: ExpansionTile(
                                    iconColor: ColorsConstants.appBarColor,
                                    tilePadding: EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 8,
                                    ),
                                    childrenPadding: EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 8,
                                    ),
                                    title: Row(
                                      children: [
                                        Icon(
                                          Icons.calendar_month_outlined,
                                          color: ColorsConstants.appBarColor,
                                          size: 20,
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          dataSomente,
                                          style: context.cusotomFontes.textBold
                                              .copyWith(
                                                color:
                                                    ColorsConstants.appBarColor,
                                              ),
                                        ),
                                      ],
                                    ),
                                    children: [
                                      ListTile(
                                        leading: Icon(
                                          LucideIcons.fileText,
                                          color: ColorsConstants.appBarColor,
                                          size: 20,
                                        ),
                                        title: Text(
                                          consultasDetalhe.servico ?? "",
                                          style: context
                                              .cusotomFontes
                                              .textItalic
                                              .copyWith(
                                                color:
                                                    ColorsConstants.appBarColor,
                                              ),
                                        ),
                                      ),
                                      ListTile(
                                        leading: Icon(
                                          consultasDetalhe.status == 'Realizado'
                                              ? Icons
                                                    .check_circle_outline_outlined
                                              : Icons.cancel_outlined,
                                          color:
                                              consultasDetalhe.status ==
                                                  'Realizado'
                                              ? Colors.green
                                              : ColorsConstants.errorColor,
                                          size: 20,
                                        ),
                                        title: Text(
                                          consultasDetalhe.status ?? "",
                                          style: context
                                              .cusotomFontes
                                              .textItalic
                                              .copyWith(
                                                color:
                                                    consultasDetalhe.status ==
                                                        'Realizado'
                                                    ? Colors.green
                                                    : ColorsConstants
                                                          .errorColor,
                                              ),
                                        ),
                                      ),
                                      ListTile(
                                        title: Text(
                                          consultasDetalhe.atendimento ?? '',
                                          style: context
                                              .cusotomFontes
                                              .textItalic
                                              .copyWith(
                                                color:
                                                    ColorsConstants.appBarColor,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
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

// ListView.builder(
//                       itemCount: historicos.length,
//                       itemBuilder: (context, index) {
//                         final item = historicos[index];

//                         return Container(

//                           child: ClipRRect(
//                             
//                             child: Theme(
                             
//                               child: ExpansionTile(
                                
//                                 children: item.arquivos.map((arquivoUrl) {
//                                   final nomeArquivo = arquivoUrl
//                                       .split('/')
//                                       .last;

                                  
//                                 }).toList(),
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                     ),
