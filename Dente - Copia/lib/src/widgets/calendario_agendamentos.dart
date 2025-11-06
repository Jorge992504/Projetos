import 'dart:developer';

import 'package:dente/core/ui/style/custom_colors.dart';
import 'package:dente/core/ui/style/fontes_letras.dart';
import 'package:dente/src/models/response/agendamentos_model_response.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarioAgendamentos extends StatefulWidget {
  final DateTime mesAtual;

  final Map<DateTime, List<AgendamentosModelResponse>>? agendamentosPorData;

  const CalendarioAgendamentos({
    super.key,

    required this.mesAtual,
    this.agendamentosPorData,
  });

  @override
  State<CalendarioAgendamentos> createState() => _CalendarioAgendamentosState();
}

class _CalendarioAgendamentosState extends State<CalendarioAgendamentos> {
  late DateTime mesAtual;

  late Map<DateTime, List<AgendamentosModelResponse>>? agendamentosPorData;
  late int? diaSelecionado;
  late bool isSelecionado;
  List<AgendamentosModelResponse> agendamentos = [];

  @override
  void initState() {
    super.initState();
    mesAtual = widget.mesAtual;
    agendamentosPorData = widget.agendamentosPorData;
    diaSelecionado = 0;
    isSelecionado = false;
  }

  @override
  Widget build(BuildContext context) {
    final inicioMes = DateTime(widget.mesAtual.year, widget.mesAtual.month, 1);
    final primeiroDiaSemana = inicioMes.weekday % 7;
    final agora = DateTime.now();
    final fimMes = DateTime(widget.mesAtual.year, widget.mesAtual.month + 1, 0);
    final diasMes = fimMes.day;
    final totalDias = diasMes + primeiroDiaSemana;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: ColorsConstants.primaryColor,
      ),
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        color: ColorsConstants.primaryColor,
        shadowColor: ColorsConstants.appBarColor,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      size: 20,
                      color: ColorsConstants.appBarColor,
                    ),
                    onPressed: () {},
                  ),
                  Text(
                    '${toBeginningOfSentenceCase(DateFormat.MMMM('pt_BR').format(mesAtual))} de ${mesAtual.year}',

                    style: context.cusotomFontes.textBoldItalic.copyWith(
                      color: ColorsConstants.appBarColor,
                      fontSize: 20,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                      color: ColorsConstants.appBarColor,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            Row(
              children: ['D', 'S', 'T', 'Q', 'Q', 'S', 'S']
                  .map(
                    (d) => Expanded(
                      child: Center(
                        child: Text(
                          d,
                          style: context.cusotomFontes.textRegular.copyWith(
                            color: ColorsConstants.appBarColor,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
            Expanded(
              child: GridView.builder(
                shrinkWrap: true,
                // physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  crossAxisSpacing: 6,
                  mainAxisSpacing: 6,
                ),
                itemCount: totalDias,
                itemBuilder: (context, index) {
                  if (index < primeiroDiaSemana) {
                    return const SizedBox.shrink();
                  }

                  final dia = index - primeiroDiaSemana + 1;
                  final dataAtual = DateTime(
                    widget.mesAtual.year,
                    widget.mesAtual.month,
                    dia,
                  );

                  final isHoje =
                      dataAtual.day == agora.day &&
                      dataAtual.month == agora.month &&
                      dataAtual.year == agora.year;

                  final agendamentosDia =
                      widget.agendamentosPorData![dataAtual] ?? [];

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
                            style: context.cusotomFontes.textItalic.copyWith(
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
          ],
        ),
      ),
    );
  }
}
