import 'package:faltou_nada/app/core/ui/base/base_state.dart';
import 'package:faltou_nada/app/core/ui/style/custom_colors.dart';
import 'package:faltou_nada/app/core/ui/style/custom_images.dart';
import 'package:faltou_nada/app/core/ui/style/fontes_letras.dart';
import 'package:faltou_nada/app/core/ui/style/size_extension.dart';
import 'package:faltou_nada/app/src/models/dashboard_model.dart';
import 'package:faltou_nada/app/src/pages/dashboard/dashboard_controller.dart';
import 'package:faltou_nada/app/src/pages/dashboard/dashboard_state.dart';
import 'package:faltou_nada/app/src/pages/dashboard/widgets/dashboard_card.dart';
import 'package:faltou_nada/app/src/widgets/custom_bar_code.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState
    extends BaseState<DashboardPage, DashboardController> {
  List<bool> expandedStates = [];
  List<double> height = [];
  String? url;
  String? ano, mes;
  int mesParts = 0;
  List<DashboardItensModel>? itens;

  @override
  void onReady() async {
    super.onReady();
    await controller.buscaGastos();
    expandedStates = List.filled(controller.state.cabeca!.length, false);
    height = List.filled(controller.state.cabeca!.length, 130);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DashboardController, DashboardState>(
      listener: (context, state) {
        state.status.matchAny(
          any: hideLoader,
          loading: showLoader,
          loaded: hideLoader,
          failure: () {
            showError(state.errorMessage ?? 'INTERNAL_ERROR');
            hideLoader();
          },
          success: hideLoader,
        );
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(color: ColorsConstants.fundoCampos),
            title: Row(
              children: [
                Text(
                  'DashBoard',
                  style: context.fontesLetras.textThin.copyWith(
                    fontSize: 20,
                    color: ColorsConstants.fundoCampos,
                  ),
                ),
                const SizedBox(width: 15),
                SizedBox(
                  child: Image.asset(
                    ImageConstants.dashboardMercado20,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(right: 16, top: 16),
                  alignment: Alignment.topRight,
                  child: CircleAvatar(
                    backgroundColor: ColorsConstants.appBar,
                    foregroundColor: ColorsConstants.fundoCampos,
                    child: InkWell(
                      onTap: () async {
                        final result = await openCamera();
                        if (result) {
                          final envie = await controller.enviarUrl(
                            url!,
                            "empresa",
                          );
                          if (envie) {
                            setState(() {
                              url = '';
                            });
                            await controller.buscaGastos();
                          }
                        }
                      },
                      child: const Icon(
                        Icons.add,
                        color: ColorsConstants.fundoCampos,
                        size: 30,
                      ),
                    ),
                  ),
                ),
                // Visibility(
                //   visible: url != null ? true : false,
                //   child: Padding(
                //     padding: const EdgeInsets.only(top: 16),
                //     child: DashboardUrl(url: url),
                //   ),
                // ),
                // Visibility(
                //   visible: url != null ? true : false,
                //   child: Padding(
                //     padding: const EdgeInsets.only(top: 16),
                //     child: SizedBox(
                //       width: context.percentWidth(.95),
                //       child: TextField(
                //         decoration: InputDecoration(
                //           suffixIcon: IconButton(
                //             onPressed: () {},
                //             icon: const Icon(
                //               Icons.send,
                //               size: 20,
                //               color: ColorsConstants.appBar,
                //             ),
                //           ),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.cabeca!.length,
                    itemBuilder: (context, index) {
                      int anoInt = 0;
                      int mesInt = 0;
                      DashboardModel dashboardModel = state.cabeca![index];
                      if (dashboardModel.data != null &&
                          dashboardModel.data!.contains('-')) {
                        List<String> dataParts = dashboardModel.data!.split(
                          '-',
                        );
                        anoInt = int.tryParse(dataParts[0]) ?? 0;
                        mesInt = int.tryParse(dataParts[1]) ?? 0;
                        ano = dataParts[0];
                        List<String> meses = [
                          'Janeiro',
                          'Fevereiro',
                          'Março',
                          'Abril',
                          'Maio',
                          'Junho',
                          'Julho',
                          'Agosto',
                          'Setembro',
                          'Outubro',
                          'Novembro',
                          'Dezembro',
                        ];
                        mes = meses[mesInt - 1];
                      }

                      return DashboardCard(
                        dataTime: "$mes de $ano",
                        vlTotal: "R\$ ${dashboardModel.vlTotal}",
                        isExpanded: expandedStates[index],
                        onTap: () {
                          onTap(index, mesInt, anoInt);
                        },
                        height: height[index],
                        itens: state.itens,
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
  }

  void onTap(int index, int mes, int ano) async {
    setState(() {
      // alterna apenas o estado do card clicado
      expandedStates[index] = !expandedStates[index];
      height[index] = expandedStates[index]
          ? context.percentHeight(0.7) // altura expandida
          : 130; // altura normal
    });

    // busca itens apenas se o card acabou de ser expandido
    if (expandedStates[index]) {
      await controller.buscaItensGastos(mes, ano);
      setState(() {
        itens = controller.state.itens ?? [];
      });
    }
  }

  Future<bool> openCamera() async {
    var codeBar = await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const BarcodeScannerSimple()),
    );
    if (codeBar != null) {
      setState(() {
        url = codeBar;
      });
      return true;
    } else {
      return false;
    }
  }
}
