import 'package:faltou_nada/app/core/ui/base/base_state.dart';
import 'package:faltou_nada/app/core/ui/style/custom_colors.dart';
import 'package:faltou_nada/app/core/ui/style/custom_images.dart';
import 'package:faltou_nada/app/core/ui/style/fontes_letras.dart';
import 'package:faltou_nada/app/core/ui/style/size_extension.dart';
import 'package:faltou_nada/app/src/models/dashboard_model.dart';
import 'package:faltou_nada/app/src/pages/dashboard/dashboard_controller.dart';
import 'package:faltou_nada/app/src/pages/dashboard/dashboard_state.dart';
import 'package:faltou_nada/app/src/pages/dashboard/widgets/dashboard_card.dart';
import 'package:faltou_nada/app/src/pages/dashboard/widgets/dashboard_url.dart';
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
  bool isExpanded = false;
  double? height;
  String? url;
  String? ano, mes;
  int mesParts = 0;
  List<DashboardItensModel>? itens;

  @override
  void onReady() async {
    super.onReady();
    await controller.buscaGastos();
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
                        await openCamera();
                      },
                      child: const Icon(
                        Icons.add,
                        color: ColorsConstants.fundoCampos,
                        size: 30,
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: url != null ? true : false,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: DashboardUrl(url: url),
                  ),
                ),
                Visibility(
                  visible: url != null ? true : false,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: SizedBox(
                      width: context.percentWidth(.95),
                      child: TextField(
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.send,
                              size: 20,
                              color: ColorsConstants.appBar,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.cabeca!.length,
                    itemBuilder: (context, index) {
                      DashboardModel dashboardModel = state.cabeca![index];
                      if (dashboardModel.data != null &&
                          dashboardModel.data!.contains('-')) {
                        List<String> dataParts = dashboardModel.data!.split(
                          '-',
                        );
                        ano = dataParts[0];
                        mesParts = int.parse(dataParts[1]);
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
                        mes = meses[mesParts - 1];
                      }

                      return DashboardCard(
                        dataTime: "$mes de $ano",
                        vlTotal: "R\$ ${dashboardModel.vlTotal}",
                        isExpanded: isExpanded,
                        onTap: onTap,
                        height: height,
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

  void onTap() async {
    if (isExpanded) {
      setState(() {
        isExpanded = !isExpanded;
        height = 130;
      });
    } else {
      setState(() async {
        isExpanded = !isExpanded;
        height = context.percentHeight(0.8);
        if (controller.state.itens!.isEmpty) {
          await controller.buscaItensGastos(mesParts, ano!);
        }
        setState(() {
          itens = controller.state.itens;
        });
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
