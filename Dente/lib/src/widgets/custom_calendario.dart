import 'package:dente/src/models/response/agendamentos_model_response.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomCalendario extends StatefulWidget {
  final List<AgendamentosModelResponse>? agendamentos;
  const CustomCalendario({super.key, this.agendamentos});

  @override
  State<CustomCalendario> createState() => _CustomCalendarioState();
}

class _CustomCalendarioState extends State<CustomCalendario> {
  late DateTime mesAtual;
  late List<AgendamentosModelResponse>? agendamentos;

  @override
  void initState() {
    super.initState();
    mesAtual = DateTime.now();
    agendamentos = agendamentos;
  }

  void mudarMes(int incremento) {
    setState(() {
      mesAtual = DateTime(mesAtual.year, mesAtual.month + incremento, 1);
    });
  }

  /// Agrupa os agendamentos por data (sem considerar a hora)
  Map<DateTime, List<AgendamentosModelResponse>> _agruparPorData() {
    final Map<DateTime, List<AgendamentosModelResponse>> mapa = {};
    for (final ag in agendamentos!) {
      final dataNormalizada = DateTime(
        ag.data!.year,
        ag.data!.month,
        ag.data!.day,
      );
      mapa.putIfAbsent(dataNormalizada, () => []).add(ag);
    }
    return mapa;
  }

  @override
  Widget build(BuildContext context) {
    final inicioMes = DateTime(mesAtual.year, mesAtual.month, 1);
    final fimMes = DateTime(mesAtual.year, mesAtual.month + 1, 0);
    final agora = DateTime.now();
    final agendamentosPorData = _agruparPorData();
    return Card(
      color: const Color(0xFFBABEBE),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            // Cabeçalho com o mês e ano
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Color(0xFF193B54),
                  ),
                  onPressed: () => mudarMes(-1),
                ),
                Text(
                  '${toBeginningOfSentenceCase(DateFormat.MMMM('pt_BR').format(mesAtual))} de ${mesAtual.year}',
                  style: const TextStyle(
                    color: Color(0xFF193B54),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.arrow_forward_ios,
                    color: Color(0xFF193B54),
                  ),
                  onPressed: () => mudarMes(1),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Cabeçalho dos dias da semana
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: ['S', 'T', 'Q', 'Q', 'S', 'S', 'D']
                  .map(
                    (d) => Expanded(
                      child: Center(
                        child: Text(
                          d,
                          style: const TextStyle(
                            color: Color(0xFF193B54),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 8),
            // Grade de dias do mês
            LayoutBuilder(
              builder: (context, constraints) {
                final diasMes = fimMes.day;
                final colunas = 7;
                final primeiroDiaSemana = inicioMes.weekday % 7;
                final totalItens = diasMes + primeiroDiaSemana;

                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: totalItens,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                    crossAxisSpacing: 6,
                    mainAxisSpacing: 6,
                  ),
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
                    final agendamentosDia =
                        agendamentosPorData[dataAtual] ?? [];

                    final isHoje =
                        dataAtual.day == agora.day &&
                        dataAtual.month == agora.month &&
                        dataAtual.year == agora.year;

                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0xFF193B54),
                            offset: Offset(0, 1),
                            blurRadius: 2,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Número do dia
                          Container(
                            decoration: isHoje
                                ? const BoxDecoration(
                                    color: Color(0xFF193B54),
                                    shape: BoxShape.circle,
                                  )
                                : null,
                            padding: const EdgeInsets.all(6),
                            child: Text(
                              '$dia',
                              style: TextStyle(
                                fontWeight: isHoje
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color: isHoje ? Colors.white : Colors.black,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          // Quantidade de agendamentos
                          if (agendamentosDia.isNotEmpty)
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: const BoxDecoration(
                                color: Color(0xFF193B54),
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                agendamentosDia.length.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
