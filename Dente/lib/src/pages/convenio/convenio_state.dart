import 'package:dente/src/models/response/busca_servicos_dentistas_agendamento_response.dart';
import 'package:dente/src/models/response/listar_convenios_response.dart';
import 'package:match/match.dart';

part 'convenio_state.g.dart';

@match
enum ConvenioStatus { initial, loading, loaded, success, failure }

class ConvenioState {
  final ConvenioStatus status;
  final String? errorMessage;
  final List<ListarConveniosResponse>? convenioModel;
  final List<BuscaServicosAgendamentoResponse>? servicosModel;

  ConvenioState.initial()
    : status = ConvenioStatus.initial,
      errorMessage = null,
      convenioModel = [],
      servicosModel = [];
  ConvenioState({
    required this.status,
    this.errorMessage,
    this.convenioModel,
    this.servicosModel,
  });

  ConvenioState copyWith({
    ConvenioStatus? status,
    String? errorMessage,
    List<ListarConveniosResponse>? convenioModel,
    List<BuscaServicosAgendamentoResponse>? servicosModel,
  }) {
    return ConvenioState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      convenioModel: convenioModel ?? this.convenioModel,
      servicosModel: servicosModel ?? this.servicosModel,
    );
  }

  List<Object?> get props {
    return [status, errorMessage, convenioModel, servicosModel];
  }
}
