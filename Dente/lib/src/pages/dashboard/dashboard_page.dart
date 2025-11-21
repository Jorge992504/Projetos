import 'package:dente/core/router/rotas.dart';
import 'package:dente/core/ui/base/base_state.dart';
import 'package:dente/core/ui/style/custom_colors.dart';
import 'package:dente/core/ui/style/fontes_letras.dart';
import 'package:dente/src/pages/dashboard/dashboard_controller.dart';
import 'package:dente/src/pages/dashboard/dashboard_state.dart';
import 'package:dente/src/pages/dashboard/relatorios/relatorio_agendamento_page.dart';
import 'package:dente/src/pages/dashboard/relatorios/relatorio_clinico_page.dart';
import 'package:dente/src/pages/dashboard/relatorios/relatorio_financiero_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState
    extends BaseState<DashboardPage, DashboardController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard´s')),
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
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    SizedBox(
                      width: 250,
                      height: 100,
                      child: InkWell(
                        onTap: () {
                          navegarRelatoriosAgendamentos();
                        },
                        child: Card(
                          color: ColorsConstants.primaryColor,
                          elevation: 6,
                          shadowColor: ColorsConstants.appBarColor,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                  "Relatorios de Agendamentos",
                                  style: context.cusotomFontes.textBold
                                      .copyWith(
                                        color: ColorsConstants.appBarColor,
                                        fontSize: 16,
                                      ),
                                ),
                                const SizedBox(height: 16),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Icon(
                                    Icons.arrow_circle_right_outlined,
                                    color: ColorsConstants.appBarColor,
                                    size: 25,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 250,
                      height: 100,
                      child: InkWell(
                        onTap: () {
                          navegarRelatoriosClinicos();
                        },
                        child: Card(
                          color: ColorsConstants.primaryColor,
                          elevation: 6,
                          shadowColor: ColorsConstants.appBarColor,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                  "Relatórios Clínicos",
                                  style: context.cusotomFontes.textBold
                                      .copyWith(
                                        color: ColorsConstants.appBarColor,
                                        fontSize: 16,
                                      ),
                                ),
                                const SizedBox(height: 16),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Icon(
                                    Icons.arrow_circle_right_outlined,
                                    color: ColorsConstants.appBarColor,
                                    size: 25,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 250,
                      height: 100,
                      child: InkWell(
                        onTap: () {
                          navegarRelatoriosFinancieros();
                        },
                        child: Card(
                          color: ColorsConstants.primaryColor,
                          elevation: 6,
                          shadowColor: ColorsConstants.appBarColor,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                  "Relatórios Financieros",
                                  style: context.cusotomFontes.textBold
                                      .copyWith(
                                        color: ColorsConstants.appBarColor,
                                        fontSize: 16,
                                      ),
                                ),
                                const SizedBox(height: 16),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Icon(
                                    Icons.arrow_circle_right_outlined,
                                    color: ColorsConstants.appBarColor,
                                    size: 25,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 250,
                      height: 100,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            Rotas.relatorio,
                            // arguments: {'id': relatoriosModel.id},
                          );
                        },
                        child: Card(
                          color: ColorsConstants.primaryColor,
                          elevation: 6,
                          shadowColor: ColorsConstants.appBarColor,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                  "Relatórios de Pacientes",
                                  style: context.cusotomFontes.textBold
                                      .copyWith(
                                        color: ColorsConstants.appBarColor,
                                        fontSize: 16,
                                      ),
                                ),
                                const SizedBox(height: 16),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Icon(
                                    Icons.arrow_circle_right_outlined,
                                    color: ColorsConstants.appBarColor,
                                    size: 25,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      width: 250,
                      height: 100,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            Rotas.relatorio,
                            // arguments: {'id': relatoriosModel.id},
                          );
                        },
                        child: Card(
                          color: ColorsConstants.primaryColor,
                          elevation: 6,
                          shadowColor: ColorsConstants.appBarColor,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                  "Relatórios para Convênios",
                                  style: context.cusotomFontes.textBold
                                      .copyWith(
                                        color: ColorsConstants.appBarColor,
                                        fontSize: 16,
                                      ),
                                ),
                                const SizedBox(height: 16),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Icon(
                                    Icons.arrow_circle_right_outlined,
                                    color: ColorsConstants.appBarColor,
                                    size: 25,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void navegarRelatoriosClinicos() async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => Provider.value(
          value: Provider.of<DashboardController>(context, listen: false),
          child: RelatorioClinicoPage(),
        ),
      ),
    );
  }

  void navegarRelatoriosAgendamentos() async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => Provider.value(
          value: Provider.of<DashboardController>(context, listen: false),
          child: RelatorioAgendamentoPage(),
        ),
      ),
    );
  }

  void navegarRelatoriosFinancieros() async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => Provider.value(
          value: Provider.of<DashboardController>(context, listen: false),
          child: RelatorioFinancieroPage(),
        ),
      ),
    );
  }
}
