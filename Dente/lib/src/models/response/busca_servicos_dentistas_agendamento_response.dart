class BuscaServicosDentistasAgendamentoResponse {
  List<BuscaServicosAgendamentoResponse>? servicos;
  List<BuscaDentistasAgendamentoResponse>? dentistas;
  BuscaServicosDentistasAgendamentoResponse({this.servicos, this.dentistas});

  BuscaServicosDentistasAgendamentoResponse copyWith({
    List<BuscaServicosAgendamentoResponse>? servicos,
    List<BuscaDentistasAgendamentoResponse>? dentistas,
  }) {
    return BuscaServicosDentistasAgendamentoResponse(
      servicos: servicos ?? this.servicos,
      dentistas: dentistas ?? this.dentistas,
    );
  }

  factory BuscaServicosDentistasAgendamentoResponse.fromMap(
    Map<String, dynamic> map,
  ) {
    return BuscaServicosDentistasAgendamentoResponse(
      servicos: (map['servicos'] as List)
          .map((e) => BuscaServicosAgendamentoResponse.fromMap(e))
          .toList(),
      dentistas: (map['dentistas'] as List)
          .map((e) => BuscaDentistasAgendamentoResponse.fromMap(e))
          .toList(),
    );
  }
}

//todo: classes para receber os servicos e seus ids-------------------------------------------------------------------- /
class BuscaServicosAgendamentoResponse {
  int? id;
  String? nome;
  BuscaServicosAgendamentoResponse({this.id, this.nome});

  factory BuscaServicosAgendamentoResponse.fromMap(Map<String, dynamic> map) {
    return BuscaServicosAgendamentoResponse(id: map['id'], nome: map['nome']);
  }
}

//todo: classes para receber os dentistas e seus ids-------------------------------------------------------------------- /
class BuscaDentistasAgendamentoResponse {
  int? id;
  String? nome;
  BuscaDentistasAgendamentoResponse({this.id, this.nome});

  factory BuscaDentistasAgendamentoResponse.fromMap(Map<String, dynamic> map) {
    return BuscaDentistasAgendamentoResponse(id: map['id'], nome: map['nome']);
  }
}
