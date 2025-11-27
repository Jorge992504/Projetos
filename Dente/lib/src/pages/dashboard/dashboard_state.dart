import 'package:dente/src/models/response/lista_procedimentos_realizados_model.dart';
import 'package:dente/src/models/response/relatorio_agendamento_cabeca_response.dart';
import 'package:dente/src/models/response/relatorio_financiero_mensal_response.dart';
import 'package:match/match.dart';

part 'dashboard_state.g.dart';

@match
enum DashboardStatus { initial, loading, loaded, success, failure }

class DashboardState {
  final DashboardStatus status;
  final String? errorMessage;

  final List<ListaProcedimentosRealizadosModel>? procedimentosRealizados;
  final List<RelatorioAgendamentoCabecaResponse>? relatoriosAgendamentos;
  final List<RelatorioFinancieroMensalResponse>? relatoriosFinancieros;

  DashboardState.initial()
    : status = DashboardStatus.initial,
      errorMessage = null,
      procedimentosRealizados = [],
      relatoriosAgendamentos = [],
      relatoriosFinancieros = [];
  DashboardState({
    required this.status,
    this.errorMessage,
    this.procedimentosRealizados,
    this.relatoriosAgendamentos,
    this.relatoriosFinancieros,
  });

  DashboardState copyWith({
    DashboardStatus? status,
    String? errorMessage,
    List<ListaProcedimentosRealizadosModel>? procedimentosRealizados,
    List<RelatorioAgendamentoCabecaResponse>? relatoriosAgendamentos,
    List<RelatorioFinancieroMensalResponse>? relatoriosFinancieros,
  }) {
    return DashboardState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      procedimentosRealizados:
          procedimentosRealizados ?? this.procedimentosRealizados,
      relatoriosAgendamentos:
          relatoriosAgendamentos ?? this.relatoriosAgendamentos,
      relatoriosFinancieros:
          relatoriosFinancieros ?? this.relatoriosFinancieros,
    );
  }

  List<Object?> get props {
    return [
      status,
      errorMessage,
      procedimentosRealizados,
      relatoriosAgendamentos,
      relatoriosFinancieros,
    ];
  }
}
