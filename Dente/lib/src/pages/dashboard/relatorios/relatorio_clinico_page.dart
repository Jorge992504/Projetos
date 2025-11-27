import 'package:dente/core/ui/base/base_state.dart';
import 'package:dente/core/ui/style/custom_colors.dart';
import 'package:dente/core/ui/style/fontes_letras.dart';
import 'package:dente/core/ui/style/size_extension.dart';
import 'package:dente/src/pages/dashboard/dashboard_controller.dart';
import 'package:dente/src/pages/dashboard/dashboard_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RelatorioClinicoPage extends StatefulWidget {
  const RelatorioClinicoPage({super.key});

  @override
  State<RelatorioClinicoPage> createState() => _RelatorioClinicoPageState();
}

class _RelatorioClinicoPageState
    extends BaseState<RelatorioClinicoPage, DashboardController> {
  bool isRealizadosGeral = true;
  bool isRealizadosConcluidos = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.buscaProcedimentosRealizados('Todos');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Relatórios Clínicos')),
      body: BlocConsumer<DashboardController, DashboardState>(
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
                            isRealizadosGeral = true;
                            isRealizadosConcluidos = false;
                          });
                          controller.buscaProcedimentosRealizados('Todos');
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: 300,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: isRealizadosGeral
                                  ? ColorsConstants.primaryColor
                                  : ColorsConstants.appBarColor,
                            ),
                            borderRadius: BorderRadius.circular(18.0),
                            color: isRealizadosGeral
                                ? ColorsConstants.appBarColor
                                : ColorsConstants.primaryColor,
                          ),
                          child: Text(
                            "Procedimentos mais realizados, geral",
                            style: context.cusotomFontes.textBoldItalic
                                .copyWith(
                                  color: isRealizadosGeral
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
                            isRealizadosConcluidos = true;
                            isRealizadosGeral = false;
                          });
                          controller.buscaProcedimentosRealizados('realizados');
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: 300,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: isRealizadosConcluidos
                                  ? ColorsConstants.primaryColor
                                  : ColorsConstants.appBarColor,
                            ),
                            borderRadius: BorderRadius.circular(18.0),
                            color: isRealizadosConcluidos
                                ? ColorsConstants.appBarColor
                                : ColorsConstants.primaryColor,
                          ),
                          child: Text(
                            "Procedimentos mais realizados, concluidos",
                            style: context.cusotomFontes.textBoldItalic
                                .copyWith(
                                  color: isRealizadosConcluidos
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
                    height: context.percentHeight(0.7),
                    width: context.percentWidth(0.7),
                    child: ListView.builder(
                      itemCount: state.procedimentosRealizados?.length,
                      itemBuilder: (context, index) {
                        final item = state.procedimentosRealizados?[index];
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
                                  item?.servico ?? "",
                                  style: context.cusotomFontes.textBold
                                      .copyWith(
                                        color: ColorsConstants.appBarColor,
                                      ),
                                ),
                                children: [
                                  ListTile(
                                    leading: Icon(
                                      Icons.numbers_outlined,
                                      color: ColorsConstants.appBarColor,
                                      size: 20,
                                    ),
                                    title: Text(
                                      'Quantidade de vezes que foi realizado: ${item?.quantidade}',
                                      style: context.cusotomFontes.textItalic
                                          .copyWith(
                                            color: ColorsConstants.appBarColor,
                                          ),
                                    ),
                                    // onTap: () =>
                                    //     abrirArquivo(arquivoUrl, context),
                                  ),
                                  ListTile(
                                    leading: Icon(
                                      Icons.percent_outlined,
                                      color: ColorsConstants.appBarColor,
                                      size: 20,
                                    ),
                                    title: Text(
                                      'Percentual(referente ao total de atendimentos): ${item?.percentual}%',
                                      style: context.cusotomFontes.textItalic
                                          .copyWith(
                                            color: ColorsConstants.appBarColor,
                                          ),
                                    ),
                                    // onTap: () =>
                                    //     abrirArquivo(arquivoUrl, context),
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
}
