import 'package:dente/core/ui/base/base_state.dart';
import 'package:dente/core/ui/style/custom_colors.dart';
import 'package:dente/core/ui/style/fontes_letras.dart';
import 'package:dente/core/ui/style/size_extension.dart';
import 'package:dente/src/pages/dashboard/dashboard_controller.dart';
import 'package:dente/src/pages/dashboard/dashboard_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class RelatorioAgendamentoPage extends StatefulWidget {
  const RelatorioAgendamentoPage({super.key});

  @override
  State<RelatorioAgendamentoPage> createState() =>
      _RelatorioAgendamentoPageState();
}

class _RelatorioAgendamentoPageState
    extends BaseState<RelatorioAgendamentoPage, DashboardController> {
  bool isSemanal = true;
  bool isMensal = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.buscaRelatoriosAgendamentos('mes');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Relatorios de Agendamentos')),
      body: BlocConsumer<DashboardController, DashboardState>(
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
          return Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          //chama função procedimentos mais realizados
                          setState(() {
                            isSemanal = true;
                            isMensal = false;
                          });
                          controller.buscaRelatoriosAgendamentos('semana');
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: 100,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: isSemanal
                                  ? ColorsConstants.primaryColor
                                  : ColorsConstants.appBarColor,
                            ),
                            borderRadius: BorderRadius.circular(18.0),
                            color: isSemanal
                                ? ColorsConstants.appBarColor
                                : ColorsConstants.primaryColor,
                          ),
                          child: Text(
                            "Semanal",
                            style: context.cusotomFontes.textBoldItalic
                                .copyWith(
                                  color: isSemanal
                                      ? ColorsConstants.primaryColor
                                      : ColorsConstants.appBarColor,
                                  fontSize: 14,
                                ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      InkWell(
                        onTap: () {
                          //chama função preocedimentos pendentes
                          setState(() {
                            isSemanal = false;
                            isMensal = true;
                          });
                          controller.buscaRelatoriosAgendamentos('mes');
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: 100,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: isMensal
                                  ? ColorsConstants.primaryColor
                                  : ColorsConstants.appBarColor,
                            ),
                            borderRadius: BorderRadius.circular(18.0),
                            color: isMensal
                                ? ColorsConstants.appBarColor
                                : ColorsConstants.primaryColor,
                          ),
                          child: Text(
                            "Mensal",
                            style: context.cusotomFontes.textBoldItalic
                                .copyWith(
                                  color: isMensal
                                      ? ColorsConstants.primaryColor
                                      : ColorsConstants.appBarColor,
                                  fontSize: 14,
                                ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),
                  SizedBox(
                    height: context.percentHeight(0.8),
                    width: context.percentWidth(0.7),
                    child: ListView.builder(
                      itemCount: state.relatoriosAgendamentos?.length,
                      itemBuilder: (context, index) {
                        final item = state.relatoriosAgendamentos?[index];

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
                                title: Text(
                                  item?.tipo == "semana"
                                      ? 'Do ${item?.inicio} até ${item?.fim}'
                                      : formatarMesAno(item?.inicio ?? ""),
                                  style: context.cusotomFontes.textBold
                                      .copyWith(
                                        color: ColorsConstants.appBarColor,
                                      ),
                                ),
                                children: [
                                  ListTile(
                                    leading: Icon(
                                      Icons.summarize_outlined,
                                      color: ColorsConstants.appBarColor,
                                      size: 20,
                                    ),
                                    title: Text(
                                      'Quantidade total de atendimentos: ${item?.total}',
                                      style: context.cusotomFontes.textItalic
                                          .copyWith(
                                            color: ColorsConstants.appBarColor,
                                          ),
                                    ),
                                  ),
                                  ListTile(
                                    leading: Icon(
                                      Icons.check_box_outlined,
                                      color: ColorsConstants.appBarColor,
                                      size: 20,
                                    ),
                                    title: Text(
                                      'Realizados: ${item?.realizados}',
                                      style: context.cusotomFontes.textItalic
                                          .copyWith(
                                            color: ColorsConstants.appBarColor,
                                          ),
                                    ),
                                  ),
                                  ListTile(
                                    leading: Icon(
                                      Icons.cancel_presentation_outlined,
                                      color: ColorsConstants.appBarColor,
                                      size: 20,
                                    ),
                                    title: Text(
                                      'Cancelados: ${item?.cancelados}',
                                      style: context.cusotomFontes.textItalic
                                          .copyWith(
                                            color: ColorsConstants.appBarColor,
                                          ),
                                    ),
                                  ),
                                  ListTile(
                                    leading: Icon(
                                      Icons.pending_actions_outlined,
                                      color: ColorsConstants.appBarColor,
                                      size: 20,
                                    ),
                                    title: Text(
                                      'Pendentes: ${item?.pendentes}',
                                      style: context.cusotomFontes.textItalic
                                          .copyWith(
                                            color: ColorsConstants.appBarColor,
                                          ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 200,
                                    child: ListView.builder(
                                      itemCount: item?.agendamentos?.length,
                                      itemBuilder: (context, index) {
                                        final subItem =
                                            item?.agendamentos?[index];
                                        // String dataFormatada = formatarData(item.data);

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
                                            borderRadius: BorderRadius.circular(
                                              16,
                                            ),
                                            child: Theme(
                                              data: Theme.of(context).copyWith(
                                                dividerColor: Colors
                                                    .transparent, // remove as linhas do ExpansionTile
                                              ),
                                              child: ExpansionTile(
                                                iconColor:
                                                    ColorsConstants.appBarColor,
                                                tilePadding:
                                                    EdgeInsets.symmetric(
                                                      horizontal: 16,
                                                      vertical: 8,
                                                    ),
                                                childrenPadding:
                                                    EdgeInsets.symmetric(
                                                      horizontal: 16,
                                                      vertical: 8,
                                                    ),
                                                title: Text(
                                                  subItem?.servico ?? "",
                                                  style: context
                                                      .cusotomFontes
                                                      .textBold
                                                      .copyWith(
                                                        color: ColorsConstants
                                                            .appBarColor,
                                                      ),
                                                ),
                                                children: [
                                                  ListTile(
                                                    leading: Icon(
                                                      Icons.date_range_outlined,
                                                      color: ColorsConstants
                                                          .appBarColor,
                                                      size: 20,
                                                    ),
                                                    title: Text(
                                                      subItem?.data ?? "",
                                                      style: context
                                                          .cusotomFontes
                                                          .textItalic
                                                          .copyWith(
                                                            color:
                                                                ColorsConstants
                                                                    .appBarColor,
                                                          ),
                                                    ),
                                                  ),
                                                  ListTile(
                                                    leading: Icon(
                                                      Icons.timer_outlined,
                                                      color: ColorsConstants
                                                          .appBarColor,
                                                      size: 20,
                                                    ),
                                                    title: Text(
                                                      subItem?.hora ?? "",
                                                      style: context
                                                          .cusotomFontes
                                                          .textItalic
                                                          .copyWith(
                                                            color:
                                                                ColorsConstants
                                                                    .appBarColor,
                                                          ),
                                                    ),
                                                  ),
                                                  ListTile(
                                                    leading: Icon(
                                                      subItem?.status ==
                                                              "Realizado"
                                                          ? Icons
                                                                .verified_outlined
                                                          : subItem?.status ==
                                                                "Cancelado"
                                                          ? Icons
                                                                .cancel_outlined
                                                          : Icons
                                                                .pending_outlined,
                                                      color: ColorsConstants
                                                          .appBarColor,
                                                      size: 20,
                                                    ),
                                                    title: Text(
                                                      subItem?.status ?? "",
                                                      style: context
                                                          .cusotomFontes
                                                          .textItalic
                                                          .copyWith(
                                                            color:
                                                                ColorsConstants
                                                                    .appBarColor,
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
      ),
    );
  }

  String formatarMesAno(String data) {
    final date = DateFormat("dd/MM/yyyy").parse(data);

    String texto = DateFormat("MMMM 'de' yyyy", 'pt_BR').format(date);

    // Apenas primeira letra maiúscula
    return texto[0].toUpperCase() + texto.substring(1);
  }
}
