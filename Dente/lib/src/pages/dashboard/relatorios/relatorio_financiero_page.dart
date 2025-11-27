import 'package:dente/core/ui/base/base_state.dart';
import 'package:dente/core/ui/style/custom_colors.dart';
import 'package:dente/core/ui/style/fontes_letras.dart';
import 'package:dente/core/ui/style/size_extension.dart';
import 'package:dente/src/pages/dashboard/dashboard_controller.dart';
import 'package:dente/src/pages/dashboard/dashboard_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RelatorioFinancieroPage extends StatefulWidget {
  const RelatorioFinancieroPage({super.key});

  @override
  State<RelatorioFinancieroPage> createState() =>
      RelatorioFinancieroPageState();
}

class RelatorioFinancieroPageState
    extends BaseState<RelatorioFinancieroPage, DashboardController> {
  bool isMensal = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.buscaRelatoriosFinancieros();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Relatorios Financieros')),
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
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        isMensal = true;
                      });
                      controller.buscaRelatoriosFinancieros();
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
                        style: context.cusotomFontes.textBoldItalic.copyWith(
                          color: isMensal
                              ? ColorsConstants.primaryColor
                              : ColorsConstants.appBarColor,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: context.percentHeight(0.8),
                  width: context.percentWidth(0.7),
                  child: ListView.builder(
                    itemCount: state.relatoriosFinancieros?.length,
                    itemBuilder: (context, index) {
                      final item = state.relatoriosFinancieros?[index];

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
                                '${item?.mes} - ${item?.valorTotal != null ? 'Valor Total: R\$ ${item?.valorTotal!.toStringAsFixed(2)}' : 'Valor Total: R\$ 0.00'}',
                                style: context.cusotomFontes.textBold.copyWith(
                                  color: ColorsConstants.appBarColor,
                                ),
                              ),
                              children: [
                                SizedBox(
                                  height: 200,
                                  child: ListView.builder(
                                    itemCount: item?.itens?.length,
                                    itemBuilder: (context, index) {
                                      final subItem = item?.itens?[index];
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
                                              tilePadding: EdgeInsets.symmetric(
                                                horizontal: 16,
                                                vertical: 8,
                                              ),
                                              childrenPadding:
                                                  EdgeInsets.symmetric(
                                                    horizontal: 16,
                                                    vertical: 8,
                                                  ),
                                              title: Text(
                                                subItem?.dataPagamento ?? "",
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
                                                    Icons.medical_services,
                                                    color: ColorsConstants
                                                        .appBarColor,
                                                    size: 20,
                                                  ),
                                                  title: Text(
                                                    subItem?.servico ?? "",
                                                    style: context
                                                        .cusotomFontes
                                                        .textItalic
                                                        .copyWith(
                                                          color: ColorsConstants
                                                              .appBarColor,
                                                        ),
                                                  ),
                                                ),
                                                ListTile(
                                                  leading: Icon(
                                                    subItem?.valorRecebido !=
                                                            null
                                                        ? Icons
                                                              .arrow_downward_outlined
                                                        : Icons
                                                              .arrow_upward_outlined,
                                                    size: 20,
                                                  ),
                                                  title: Text(
                                                    subItem?.valorRecebido !=
                                                            null
                                                        ? 'Recebido: R\$ ${subItem?.valorRecebido!.toStringAsFixed(2)}'
                                                        : 'Pago: R\$ ${subItem?.valorRecebido!.toStringAsFixed(2)}',
                                                    style: context
                                                        .cusotomFontes
                                                        .textItalic
                                                        .copyWith(
                                                          color: ColorsConstants
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
          );
        },
      ),
    );
  }
}
