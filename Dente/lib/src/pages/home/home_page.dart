import 'dart:developer';

import 'package:dente/core/router/rotas.dart';
import 'package:dente/core/ui/style/custom_colors.dart';
import 'package:dente/core/ui/style/custom_images.dart';
import 'package:dente/core/ui/style/fontes_letras.dart';
import 'package:dente/src/models/empresa_model.dart';
import 'package:dente/src/models/response/agendamentos_model_response.dart';
import 'package:dente/src/pages/home/widgets/calendario.dart';
import 'package:dente/src/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late DateTime mesAtual;
  late Map<DateTime, List<AgendamentosModelResponse>>? agendamentosPorData;

  int? diaSelecionado = 0;
  bool isSelecionado = false;

  @override
  void initState() {
    super.initState();
    mesAtual = DateTime.now();
    agendamentosPorData = agruparPorData();
  }

  //! lista para simular os agendamentos
  final agendamentos = [
    AgendamentosModelResponse(data: DateTime(2025, 10, 8), id: 1),
    AgendamentosModelResponse(data: DateTime(2025, 10, 8), id: 2),
    AgendamentosModelResponse(data: DateTime(2025, 10, 10), id: 3),
    AgendamentosModelResponse(data: DateTime(2025, 10, 15), id: 4),
    AgendamentosModelResponse(data: DateTime(2025, 10, 15), id: 5),
  ];

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

    //!criar um refresh no controller

    return Scaffold(
      appBar: AppBar(title: const Text('Agendamentos')),
      endDrawer: SafeArea(
        child: Drawer(
          backgroundColor: ColorsConstants.primaryColor,
          child: Stack(
            children: [
              ListView(
                children: [
                  UserAccountsDrawerHeader(
                    accountName: Text(
                      empresaModel.nomeClinica ?? "",
                      style: context.cusotomFontes.textBoldItalic.copyWith(
                        color: ColorsConstants.primaryColor,
                        height: 1,
                      ),
                    ),
                    accountEmail: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          empresaModel.emailClinica ?? "",
                          style: context.cusotomFontes.textRegular.copyWith(
                            color: ColorsConstants.primaryColor,
                            height: 1,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(
                              context,
                            ).pushNamed(Rotas.editarEmpresa);
                          },
                          child: Text(
                            "Editar",
                            style: context.cusotomFontes.textItalic.copyWith(
                              fontSize: 13,
                              height: 1,
                            ),
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

                      child: empresaModel.foto == null ? Text(getNome()) : null,
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
                      style: context.cusotomFontes.textBold,
                    ),
                    onTap: () async {
                      Navigator.of(context).pushNamed(Rotas.dentista);
                    },
                  ),
                  ListTile(
                    leading: Image.asset(
                      ImageConstants.logout,
                      width: 25,
                      height: 25,
                      fit: BoxFit.cover,
                    ),
                    title: Text("Sair", style: context.cusotomFontes.textBold),
                    onTap: () async {
                      Provider.of<AuthProvider>(
                        context,
                        listen: false,
                      ).logout();
                      Navigator.of(
                        context,
                      ).pushNamedAndRemoveUntil(Rotas.login, (route) => false);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, tamanho) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(top: 15),
                alignment: Alignment.bottomRight,
                width: 950,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(Rotas.agendamento);
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
                  height: tamanho.maxHeight * 0.7,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: ColorsConstants.primaryColor,
                  ),
                  padding: EdgeInsets.all(20),
                  child: Calendario(
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

                      final isHoje =
                          dataAtual.day == agora.day &&
                          dataAtual.month == agora.month &&
                          dataAtual.year == agora.year;

                      final agendamentosDia =
                          agendamentosPorData![dataAtual] ?? [];

                      isSelecionado = dia == diaSelecionado;

                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  diaSelecionado = dia;
                                  agendamentos.clear();
                                });
                                if (agendamentosDia.isNotEmpty) {
                                  agendamentos.addAll(agendamentosDia);
                                  log('-----------------> $agendamentos');
                                }
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
            ],
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
  Map<DateTime, List<AgendamentosModelResponse>>? agruparPorData() {
    final Map<DateTime, List<AgendamentosModelResponse>> mapa = {};
    for (final ag in agendamentos) {
      final dataNormalizada = DateTime(
        ag.data!.year,
        ag.data!.month,
        ag.data!.day,
      );
      mapa.putIfAbsent(dataNormalizada, () => []).add(ag);
    }
    return mapa;
  }
}
