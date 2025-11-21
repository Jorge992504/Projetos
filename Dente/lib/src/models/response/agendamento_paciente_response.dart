// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AgendamentoPacienteResponse {
  int? pacienteId;
  int? agendamentoId;
  int? servicoId;
  String? status;
  String? pacienteNome;
  String? servico;
  String? datahorario;
  String? observacoes;
  num? vl;
  AgendamentoPacienteResponse({
    this.pacienteId,
    this.agendamentoId,
    this.status,
    this.pacienteNome,
    this.servico,
    this.datahorario,
    this.observacoes,
    this.vl,
    this.servicoId,
  });

  AgendamentoPacienteResponse copyWith({
    int? pacienteId,
    int? agendamentoId,
    String? status,
    String? pacienteNome,
    String? servico,
    String? datahorario,
    String? observacoes,
    num? vl,
    int? servicoId,
  }) {
    return AgendamentoPacienteResponse(
      pacienteId: pacienteId ?? this.pacienteId,
      agendamentoId: agendamentoId ?? this.agendamentoId,
      status: status ?? this.status,
      pacienteNome: pacienteNome ?? this.pacienteNome,
      servico: servico ?? this.servico,
      datahorario: datahorario ?? this.datahorario,
      observacoes: observacoes ?? this.observacoes,
      vl: vl ?? this.vl,
      servicoId: servicoId ?? this.servicoId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pacienteId': pacienteId,
      'agendamentoId': agendamentoId,
      'status': status,
      'pacienteNome': pacienteNome,
      'servico': servico,
      'datahorario': datahorario,
      'observacoes': observacoes,
      'vl': vl,
      'servicoId': servicoId,
    };
  }

  factory AgendamentoPacienteResponse.fromMap(Map<String, dynamic> map) {
    return AgendamentoPacienteResponse(
      pacienteId: map['pacienteId'] ?? 0,
      agendamentoId: map['agendamentoId'] ?? 0,
      status: map['status'] ?? "",
      pacienteNome: map['pacienteNome'] ?? "",
      servico: map['servico'] ?? "",
      datahorario: map['datahorario'] ?? "",
      observacoes: map['observacoes'] ?? "",
      vl: map['vl'] ?? 0.0,
      servicoId: map['servicoId'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory AgendamentoPacienteResponse.fromJson(String source) =>
      AgendamentoPacienteResponse.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  @override
  String toString() {
    return 'AgendamentoPacienteResponse(pacienteId: $pacienteId, agendamentoId: $agendamentoId, status: $status, pacienteNome: $pacienteNome, servico: $servico, datahorario: $datahorario, observacoes: $observacoes, vl: $vl, servicoId: $servicoId)';
  }

  @override
  bool operator ==(covariant AgendamentoPacienteResponse other) {
    if (identical(this, other)) return true;

    return other.pacienteId == pacienteId &&
        other.agendamentoId == agendamentoId &&
        other.status == status &&
        other.pacienteNome == pacienteNome &&
        other.servico == servico &&
        other.datahorario == datahorario &&
        other.observacoes == observacoes &&
        other.vl == vl &&
        other.servicoId == servicoId;
  }

  @override
  int get hashCode {
    return pacienteId.hashCode ^
        agendamentoId.hashCode ^
        status.hashCode ^
        pacienteNome.hashCode ^
        servico.hashCode ^
        datahorario.hashCode ^
        observacoes.hashCode ^
        vl.hashCode ^
        servicoId.hashCode;
  }
}
