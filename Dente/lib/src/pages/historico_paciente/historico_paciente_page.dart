import 'dart:io';
import 'package:dente/core/rest_client/rest_client.dart';
import 'package:dente/core/ui/base/base_state.dart';
import 'package:dente/core/ui/style/custom_colors.dart';
import 'package:dente/core/ui/style/fontes_letras.dart';
import 'package:dente/core/ui/style/size_extension.dart';
import 'package:dente/src/models/response/historico_arquivos_response.dart';
import 'package:dente/src/pages/historico_paciente/historico_paciente_controller.dart';
import 'package:dente/src/pages/historico_paciente/historico_paciente_state.dart';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class HistoricoPacientePage extends StatefulWidget {
  const HistoricoPacientePage({super.key});

  @override
  State<HistoricoPacientePage> createState() => _HistoricoPacientePageState();
}

class _HistoricoPacientePageState
    extends BaseState<HistoricoPacientePage, HistoricoPacienteController> {
  int pacienteId = 0;
  String pacienteNm = '';
  List<HistoricoArquivosResponse> historicos = [];
  RestClient restClient = RestClient();

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
      historicos = await controller.buscaHistoricoPaciente(pacienteId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historico de documentos anexados do paciente'),
      ),
      body: BlocConsumer<HistoricoPacienteController, HistoricoPacienteState>(
        listener: (context, state) {
          state.status.matchAny(
            any: hideLoader,
            loading: showLoader,
            loaded: hideLoader,
            failure: () {
              showError(state.errorMessage ?? 'INTERNAL_ERROR');

              hideLoader();
            },
            success: () {
              hideLoader();
            },
          );
        },
        builder: (context, state) {
          return Align(
            alignment: Alignment.center,
            child: Container(
              width: 1000,
              height: context.percentHeight(1),
              padding: EdgeInsets.all(20),
              child: Column(
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
                          style: context.cusotomFontes.textBoldItalic.copyWith(
                            color: ColorsConstants.appBarColor,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: historicos.length,
                      itemBuilder: (context, index) {
                        final item = historicos[index];
                        String dataFormatada = formatarData(item.data);

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
                                  dataFormatada,
                                  style: context.cusotomFontes.textBold
                                      .copyWith(
                                        color: ColorsConstants.appBarColor,
                                      ),
                                ),
                                children: item.arquivos.map((arquivoUrl) {
                                  final nomeArquivo = arquivoUrl
                                      .split('/')
                                      .last;

                                  return ListTile(
                                    leading: Icon(
                                      Icons.insert_drive_file_outlined,
                                      color: ColorsConstants.appBarColor,
                                    ),
                                    title: Text(
                                      nomeArquivo,
                                      style: context.cusotomFontes.textItalic
                                          .copyWith(
                                            color: ColorsConstants.appBarColor,
                                          ),
                                    ),
                                    onTap: () =>
                                        abrirArquivo(arquivoUrl, context),
                                  );
                                }).toList(),
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

  Future<void> abrirArquivo(String url, BuildContext context) async {
    final tempDir = await getTemporaryDirectory();
    final localPath = '${tempDir.path}/${url.split('/').last}';
    final file = File(localPath);

    // Baixa o arquivo se não existir
    if (!await file.exists()) {
      final response = await restClient.auth.get(
        url,
        options: Options(responseType: ResponseType.bytes),
      );
      await file.writeAsBytes(response.data);
    }

    try {
      if (Platform.isWindows) {
        await Process.run('cmd', [
          '/c',
          'start',
          '',
          file.path,
        ], runInShell: true);
      } else if (Platform.isMacOS) {
        await Process.run('open', [file.path]);
      } else if (Platform.isLinux) {
        await Process.run('xdg-open', [file.path]);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Plataforma não suportada')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Erro ao abrir o arquivo: $e')));
    }
  }

  String formatarData(String data) {
    final DateTime dateTime = DateTime.parse(data);
    return DateFormat('dd/MM/yyyy').format(dateTime);
  }
}
