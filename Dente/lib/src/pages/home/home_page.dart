import 'package:dente/core/router/rotas.dart';
import 'package:dente/core/ui/base/base_state.dart';
import 'package:dente/core/ui/style/custom_colors.dart';
import 'package:dente/core/ui/style/custom_images.dart';
import 'package:dente/core/ui/style/fontes_letras.dart';
import 'package:dente/core/ui/style/size_extension.dart';
import 'package:dente/src/models/empresa_model.dart';
import 'package:dente/src/models/request/agendamento_por_paciente_request.dart';
import 'package:dente/src/models/response/agendamento_paciente_response.dart';
import 'package:dente/src/models/response/agendamentos_model_response.dart';
import 'package:dente/src/pages/home/home_controller.dart';
import 'package:dente/src/pages/home/home_state.dart';
import 'package:dente/src/pages/home/widgets/calendario.dart';
import 'package:dente/src/providers/auth_provider.dart';
import 'package:dente/src/widgets/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends BaseState<HomePage, HomeController> {
  late DateTime mesAtual;
  Map<String, List<AgendamentosModelResponse>>? agendamentosPorData = {};
  List<AgendamentosModelResponse> agendamentos = [];
  List<AgendamentosModelResponse> agendamentosSelecionados = [];
  List<AgendamentoPacienteResponse> agendamentosDetalhes = [];
  List<AgendamentosModelResponse> agendamentosDiaRefresh = [];
  List<AgendamentosModelResponse> agendamentosDia = [];

  int? diaSelecionado = 0;
  bool isSelecionado = false;
  bool isHovering = false;

  @override
  void initState() {
    super.initState();
    mesAtual = DateTime.now();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // controller.buscaAgendamentos();
      // agendamentosPorData = agruparPorData();
      await refreshAgendamentos();

      // if (controller.state.agendamentos!.isNotEmpty) {
      //   List<AgendamentoPorPacienteRequest> request = [];

      //   for (var agendamento in agendamentosDia) {
      //     request.add(
      //       AgendamentoPorPacienteRequest(
      //         data: DateFormat('yyyy-MM-dd').format(agendamento.data!),
      //         id: agendamento.id,
      //       ),
      //     );
      //   }
      //   if (request.isNotEmpty) {
      //     agendamentosDetalhes = await controller.buscarDadosDosAgendamentos(
      //       request,
      //     );
      //   } else {
      //     agendamentosDetalhes = [];
      //   }
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    final inicioMes = DateTime(mesAtual.year, mesAtual.month, 1);
    final primeiroDiaSemana = inicioMes.weekday % 7;
    final agora = DateTime.now();
    final fimMes = DateTime(mesAtual.year, mesAtual.month + 1, 0);
    final diasMes = fimMes.day;
    final totalDias = diasMes + primeiroDiaSemana;

    EmpresaModel empresaModel = Provider.of<AuthProvider>(
      context,
      listen: false,
    ).empresaModel;

    String getNome() {
      if (empresaModel.nomeClinica!.isEmpty ||
          empresaModel.nomeClinica == null) {
        return "";
      }
      String nomefinal = "";
      List<String> nomes = empresaModel.nomeClinica!.split(" ");
      if (nomes.length > 1) {
        nomefinal = '${nomes[0][0]}${nomes[nomes.length - 1][0]}';
      } else {
        try {
          nomefinal = nomes[0].substring(0, 2);
        } catch (e) {
          nomefinal = empresaModel.nomeClinica!;
        }
      }
      return nomefinal;
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Agendamentos')),
      endDrawer: BlocConsumer<HomeController, HomeState>(
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
          return SafeArea(
            child: Drawer(
              backgroundColor: ColorsConstants.primaryColor,
              child: Stack(
                children: [
                  ListView(
                    children: [
                      UserAccountsDrawerHeader(
                        accountName: SizedBox(
                          width: 250,
                          child: Text(
                            empresaModel.nomeClinica ?? "",
                            style: context.cusotomFontes.textBoldItalic
                                .copyWith(
                                  color: ColorsConstants.primaryColor,
                                  height: 1,
                                ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        accountEmail: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                empresaModel.emailClinica ?? "",
                                style: context.cusotomFontes.textRegular
                                    .copyWith(
                                      color: ColorsConstants.primaryColor,
                                      height: 1.5,
                                    ),
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(
                                  context,
                                ).pushNamed(Rotas.editarEmpresa).then((_) {
                                  // Aqui você faz o refresh da Home
                                  setState(() {
                                    // Chame sua função de recarregar os dados
                                    Provider.of(
                                      context,
                                      listen: false,
                                    ).authProvider.carregarDadosEmpresa();
                                  });
                                });
                              },
                              child: Text(
                                "Editar",
                                style: context.cusotomFontes.textItalic
                                    .copyWith(fontSize: 13, height: 1),
                                overflow: TextOverflow.visible,
                              ),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                          color: ColorsConstants.appBarColor,
                        ),
                        currentAccountPicture: CircleAvatar(
                          radius: 40, // ou maxRadius
                          backgroundColor: ColorsConstants.focusColor,
                          backgroundImage: empresaModel.foto != null
                              ? NetworkImage(empresaModel.foto!)
                              : null,

                          child: empresaModel.foto == null
                              ? Text(getNome())
                              : null,
                        ),
                        currentAccountPictureSize: const Size.square(70),
                      ),
                      ListTile(
                        leading: Image.asset(
                          ImageConstants.dentista,
                          width: 25,
                          height: 25,
                          fit: BoxFit.cover,
                        ),
                        title: Text(
                          "Dentistas",
                          style: context.cusotomFontes.textBoldItalic,
                        ),
                        onTap: () async {
                          Navigator.of(context).pushNamed(Rotas.dentista);
                        },
                      ),
                      ListTile(
                        leading: Image.asset(
                          ImageConstants.servicos,
                          width: 25,
                          height: 25,
                          fit: BoxFit.cover,
                        ),
                        title: Text(
                          "Serviços",
                          style: context.cusotomFontes.textBoldItalic,
                        ),
                        onTap: () async {
                          Navigator.of(context).pushNamed(Rotas.servicos);
                        },
                      ),
                      ListTile(
                        leading: Image.asset(
                          ImageConstants.cliente,
                          width: 25,
                          height: 25,
                          fit: BoxFit.cover,
                        ),
                        title: Text(
                          "Pacientes",
                          style: context.cusotomFontes.textBoldItalic,
                        ),
                        onTap: () async {
                          Navigator.of(
                            context,
                          ).pushNamed(Rotas.registrarPaciente);
                        },
                      ),
                      ListTile(
                        leading: Image.asset(
                          ImageConstants.calendario,
                          width: 25,
                          height: 25,
                          fit: BoxFit.cover,
                        ),
                        title: Text(
                          "Novo agendamento",
                          style: context.cusotomFontes.textBoldItalic,
                        ),
                        onTap: () async {
                          Navigator.of(
                            context,
                          ).pushNamed(Rotas.agendamento).then((_) async {
                            await refreshAgendamentos(); // método que já atualiza tudo corretamente
                          });
                        },
                      ),
                      ListTile(
                        leading: Image.asset(
                          ImageConstants.logout,
                          width: 25,
                          height: 25,
                          fit: BoxFit.cover,
                        ),
                        title: Text(
                          "Sair",
                          style: context.cusotomFontes.textBoldItalic,
                        ),
                        onTap: () async {
                          Provider.of<AuthProvider>(
                            context,
                            listen: false,
                          ).logout();
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            Rotas.login,
                            (route) => false,
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
      body: BlocConsumer<HomeController, HomeState>(
        listener: (context, state) {
          state.status.matchAny(
            any: hideLoader,
            loading: showLoader,
            loaded: hideLoader,
            failure: () {
              showError(state.errorMessage ?? 'INTERNAL_ERROR');
              if (state.errorMessage == "Token invalido, realizar login") {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    Rotas.login,
                    (route) => false, // remove todas as rotas anteriores
                  );
                });
              }

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
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 15),
                      alignment: Alignment.bottomRight,
                      width: 950,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(
                            context,
                          ).pushNamed(Rotas.agendamento).then((_) async {
                            await refreshAgendamentos(); // método que já atualiza tudo corretamente
                          });
                        },
                        child: Text(
                          'Novo agendamento',
                          style: context.cusotomFontes.textItalic.copyWith(
                            color: ColorsConstants.primaryColor,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: 1000,
                        // height: tamanho.maxHeight * 0.8,
                        height: context.percentHeight(0.8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: ColorsConstants.primaryColor,
                        ),
                        padding: EdgeInsets.all(20),
                        child: Calendario(
                          onPressedBack: () {
                            mudarMes(-1);
                          },
                          onPressedNext: () {
                            mudarMes(1);
                          },
                          labelMes:
                              '${toBeginningOfSentenceCase(DateFormat.MMMM('pt_BR').format(mesAtual))} de ${mesAtual.year}',
                          itemCount: totalDias,
                          itemBuilder: (context, index) {
                            if (index < primeiroDiaSemana) {
                              return const SizedBox.shrink();
                            }

                            final dia = index - primeiroDiaSemana + 1;
                            final dataAtual = DateTime(
                              mesAtual.year,
                              mesAtual.month,
                              dia,
                            );
                            final chave = DateFormat(
                              'yyyy-MM-dd',
                            ).format(dataAtual);
                            agendamentosDia = agendamentosPorData![chave] ?? [];

                            final isHoje =
                                dataAtual.day == agora.day &&
                                dataAtual.month == agora.month &&
                                dataAtual.year == agora.year;

                            isSelecionado = dia == diaSelecionado;

                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: GestureDetector(
                                      onTap: () async {
                                        final dataAtual = DateTime(
                                          mesAtual.year,
                                          mesAtual.month,
                                          dia,
                                        );
                                        final chave = DateFormat(
                                          'yyyy-MM-dd',
                                        ).format(dataAtual);

                                        // Pega os agendamentos do dia
                                        agendamentosDia =
                                            agendamentosPorData![chave] ?? [];
                                        setState(() {
                                          diaSelecionado = dia;
                                          agendamentosSelecionados =
                                              agendamentosDia; // apenas daquele dia
                                          agendamentosDiaRefresh =
                                              agendamentosDia;
                                        });

                                        List<AgendamentoPorPacienteRequest>
                                        request = [];

                                        for (var agendamento
                                            in agendamentosDia) {
                                          request.add(
                                            AgendamentoPorPacienteRequest(
                                              data: DateFormat(
                                                'yyyy-MM-dd',
                                              ).format(agendamento.data!),
                                              id: agendamento.id,
                                            ),
                                          );
                                        }
                                        if (request.isNotEmpty) {
                                          agendamentosDetalhes =
                                              await controller
                                                  .buscarDadosDosAgendamentos(
                                                    request,
                                                  );
                                        } else {
                                          agendamentosDetalhes = [];
                                        }
                                      },
                                      onDoubleTap: () {
                                        String data =
                                            '${dia.toString().padLeft(2, '0')}/${mesAtual.month.toString().padLeft(2, '0')}/${mesAtual.year}';

                                        if (dia < mesAtual.day) {
                                          showInfo(
                                            "Não pode realizar agendametos em datas passadas.",
                                          );
                                          return;
                                        }

                                        Navigator.of(context)
                                            .pushNamed(
                                              Rotas.agendamento,
                                              arguments: {'data': data},
                                            )
                                            .then((_) async {
                                              await refreshAgendamentos(); // método que já atualiza tudo corretamente
                                            });
                                      },
                                      child: CircleAvatar(
                                        maxRadius: 20,
                                        minRadius: 20,
                                        backgroundColor: isSelecionado
                                            ? ColorsConstants.focusColor
                                            : isHoje
                                            ? ColorsConstants.appBarColor
                                            : ColorsConstants.primaryColor,
                                        child: Text(
                                          '$dia',
                                          style: TextStyle(
                                            color: isSelecionado
                                                ? ColorsConstants.primaryColor
                                                : isHoje
                                                ? ColorsConstants.primaryColor
                                                : ColorsConstants.appBarColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                if (agendamentosDia.isNotEmpty)
                                  CircleAvatar(
                                    maxRadius: 10,

                                    backgroundColor: ColorsConstants.focusColor,
                                    // radius: 18,
                                    child: Text(
                                      agendamentosDia.length.toString(),
                                      style: context.cusotomFontes.textItalic
                                          .copyWith(
                                            color: ColorsConstants.primaryColor,
                                            fontSize: 12,
                                          ),
                                    ),
                                  ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                    Container(
                      width: 1000,
                      height: 200,
                      padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                      child: ListView.builder(
                        itemCount: agendamentosDetalhes.length,
                        itemBuilder: (context, index) {
                          AgendamentoPacienteResponse agendamentoDetalhe =
                              agendamentosDetalhes[index];

                          return Tooltip(
                            message:
                                agendamentoDetalhe.status != 'Cancelado' &&
                                    agendamentoDetalhe.status != 'Realizado'
                                ? 'Começar o atendimento'
                                : '',
                            child: InkWell(
                              overlayColor:
                                  agendamentoDetalhe.status != 'Cancelado' &&
                                      agendamentoDetalhe.status != 'Realizado'
                                  ? WidgetStateProperty.all(
                                      ColorsConstants.focusColor.withOpacity(
                                        0.2,
                                      ),
                                    )
                                  : WidgetStateProperty.all(Colors.transparent),

                              onTap: () {
                                if (agendamentoDetalhe.status != 'Cancelado' &&
                                    agendamentoDetalhe.status != 'Realizado') {
                                  // Navigator.of(context).pushNamed(
                                  //   Rotas.atendimento,
                                  //   arguments: {
                                  //     'agendamentoDetalhe': agendamentoDetalhe,
                                  //   },
                                  // );

                                  Navigator.of(context)
                                      .pushNamed(
                                        Rotas.atendimento,
                                        arguments: {
                                          'agendamentoDetalhe':
                                              agendamentoDetalhe,
                                        },
                                      )
                                      .then((_) {
                                        List<AgendamentoPorPacienteRequest>
                                        request = [];
                                        for (var agendamento
                                            in agendamentosDiaRefresh) {
                                          request.add(
                                            AgendamentoPorPacienteRequest(
                                              data: DateFormat(
                                                'yyyy-MM-dd',
                                              ).format(agendamento.data!),
                                              id: agendamento.id,
                                            ),
                                          );
                                        }
                                        if (request.isNotEmpty) {
                                          setState(() async {
                                            agendamentosDetalhes =
                                                await controller
                                                    .buscarDadosDosAgendamentos(
                                                      request,
                                                    );
                                          });
                                        } else {
                                          agendamentosDetalhes = [];
                                        }
                                      });
                                }
                              },
                              child: CustomCard(
                                // width: 1000,
                                // height: 80,
                                nome: agendamentoDetalhe.pacienteNome,
                                servico: agendamentoDetalhe.servico,
                                horario: agendamentoDetalhe.datahorario,

                                onPressedCancelado: () async {
                                  await controller
                                      .marcaAgendamentoComoCancelado(
                                        agendamentoDetalhe.agendamentoId!,
                                      );
                                  await refreshPage(agendamentosSelecionados);
                                  setState(() {});
                                },
                                onPressedConfirmado: () async {
                                  await controller
                                      .marcaAgendamentoComoRealizado(
                                        agendamentoDetalhe.agendamentoId!,
                                      );
                                  await refreshPage(agendamentosSelecionados);
                                  setState(() {});
                                },
                                onPressedHisotorico: () {
                                  Navigator.of(context).pushNamed(
                                    Rotas.historicoPaciente,
                                    arguments: {
                                      "pacienteId":
                                          agendamentoDetalhe.pacienteId,
                                      "pacienteNm":
                                          agendamentoDetalhe.pacienteNome,
                                    },
                                  );
                                },
                                onPressedHisotoricoPaciente: () {
                                  Navigator.of(context).pushNamed(
                                    Rotas.historicoConsultas,
                                    arguments: {
                                      "pacienteId":
                                          agendamentoDetalhe.pacienteId,
                                      "pacienteNm":
                                          agendamentoDetalhe.pacienteNome,
                                    },
                                  );
                                },
                                status: agendamentoDetalhe.status,
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
          );
        },
      ),
    );
  }

  void mudarMes(int incremento) {
    setState(() {
      mesAtual = DateTime(mesAtual.year, mesAtual.month + incremento, 1);
    });
  }

  //! Agrupa os agendamentos por data (sem considerar a hora)
  // Map<DateTime, List<AgendamentosModelResponse>>? agruparPorData() {
  //   final Map<DateTime, List<AgendamentosModelResponse>> mapa = {};
  //   for (final ag in controller.state.agendamentos ?? []) {
  //     final dataNormalizada = DateTime(
  //       ag.data!.year,
  //       ag.data!.month,
  //       ag.data!.day,
  //     );
  //     mapa.putIfAbsent(dataNormalizada, () => []).add(ag);
  //   }
  //   return mapa;
  // }
  Map<String, List<AgendamentosModelResponse>> agruparPorData() {
    final Map<String, List<AgendamentosModelResponse>> mapa = {};
    for (final ag in controller.state.agendamentos ?? []) {
      final chave = DateFormat('yyyy-MM-dd').format(ag.data!);
      mapa.putIfAbsent(chave, () => []).add(ag);
    }
    return mapa;
  }

  Future<void> refreshPage(
    List<AgendamentosModelResponse> agendamentosDia,
  ) async {
    List<AgendamentoPorPacienteRequest> request = [];
    for (var agendamento in agendamentosDia) {
      request.add(
        AgendamentoPorPacienteRequest(
          data: DateFormat('yyyy-MM-dd').format(agendamento.data!),
          id: agendamento.id,
        ),
      );
    }
    if (request.isNotEmpty) {
      agendamentosDetalhes = await controller.buscarDadosDosAgendamentos(
        request,
      );
    } else {
      agendamentosDetalhes = [];
    }
  }

  Future<void> refreshAgendamentos() async {
    await controller.buscaAgendamentos();

    agendamentosPorData = agruparPorData();

    final hoje = DateTime.now();
    final chaveHoje = DateFormat('yyyy-MM-dd').format(hoje);
    final agendamentosHoje = agendamentosPorData?[chaveHoje] ?? [];

    if (agendamentosHoje.isNotEmpty) {
      setState(() {
        diaSelecionado = hoje.day;
        agendamentosDia = agendamentosHoje;
        agendamentosSelecionados = agendamentosHoje;
        agendamentosDiaRefresh = agendamentosHoje;
      });

      final request = agendamentosHoje.map((ag) {
        return AgendamentoPorPacienteRequest(
          data: DateFormat('yyyy-MM-dd').format(ag.data!),
          id: ag.id,
        );
      }).toList();

      final detalhes = await controller.buscarDadosDosAgendamentos(request);
      setState(() {
        agendamentosDetalhes = detalhes;
      });
    } else {
      setState(() {
        agendamentosDetalhes = [];
      });
    }
  }
}
