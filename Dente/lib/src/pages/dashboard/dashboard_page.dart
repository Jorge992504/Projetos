import 'dart:developer';

import 'package:dente/core/router/rotas.dart';
import 'package:dente/core/ui/base/base_state.dart';
import 'package:dente/core/ui/style/custom_colors.dart';
import 'package:dente/core/ui/style/fontes_letras.dart';
import 'package:dente/src/models/request/lista_relatorios_model.dart';
import 'package:dente/src/pages/dashboard/dashboard_controller.dart';
import 'package:dente/src/pages/dashboard/dashboard_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState
    extends BaseState<DashboardPage, DashboardController> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await controller.buscaRelatorios();
    });
  }

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
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 8,
              childAspectRatio: 3,
            ),
            padding: EdgeInsets.all(30),
            itemCount: state.relatorios?.length ?? 0,
            itemBuilder: (context, index) {
              ListaRelatoriosModel relatoriosModel = state.relatorios![index];
              return InkWell(
                onTap: () {
                  log(relatoriosModel.id.toString());
                  Navigator.of(context).pushNamed(
                    Rotas.relatorio,
                    arguments: {'id': relatoriosModel.id},
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
                        const SizedBox(height: 14),
                        Text(
                          relatoriosModel.descricao ?? "",
                          style: context.cusotomFontes.textBold.copyWith(
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
              );
            },
          );
        },
      ),
    );
  }
}
