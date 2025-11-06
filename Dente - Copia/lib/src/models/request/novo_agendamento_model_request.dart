// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class NovoAgendamentoModelRequest {
  String? dataHora;
  String? cpfPaciente;
  int? dentistaId;
  int? servicoId;
  String? observacoes;
  NovoAgendamentoModelRequest({
    this.dataHora,
    this.cpfPaciente,
    this.dentistaId,
    this.servicoId,
    this.observacoes,
  });

  NovoAgendamentoModelRequest copyWith({
    String? dataHora,
    String? cpfPaciente,
    int? dentistaId,
    int? servicoId,
    String? observacoes,
  }) {
    return NovoAgendamentoModelRequest(
      dataHora: dataHora ?? this.dataHora,
      cpfPaciente: cpfPaciente ?? this.cpfPaciente,
      dentistaId: dentistaId ?? this.dentistaId,
      servicoId: servicoId ?? this.servicoId,
      observacoes: observacoes ?? this.observacoes,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'dataHora': dataHora,
      'cpfPaciente': cpfPaciente,
      'dentistaId': dentistaId,
      'servicoId': servicoId,
      'observacoes': observacoes,
    };
  }

  factory NovoAgendamentoModelRequest.fromMap(Map<String, dynamic> map) {
    return NovoAgendamentoModelRequest(
      dataHora: map['dataHora'] ?? "",
      cpfPaciente: map['cpfPaciente'] ?? "",
      dentistaId: map['dentistaId'] ?? 0,
      servicoId: map['servicoId'] ?? 0,
      observacoes: map['observacoes'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory NovoAgendamentoModelRequest.fromJson(String source) =>
      NovoAgendamentoModelRequest.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  @override
  String toString() {
    return 'NovoAgendamentoModelRequest(dataHora: $dataHora, cpfPaciente: $cpfPaciente, dentistaId: $dentistaId, servicoId: $servicoId, observacoes: $observacoes)';
  }

  @override
  bool operator ==(covariant NovoAgendamentoModelRequest other) {
    if (identical(this, other)) return true;

    return other.dataHora == dataHora &&
        other.cpfPaciente == cpfPaciente &&
        other.dentistaId == dentistaId &&
        other.servicoId == servicoId &&
        other.observacoes == observacoes;
  }

  @override
  int get hashCode {
    return dataHora.hashCode ^
        cpfPaciente.hashCode ^
        dentistaId.hashCode ^
        servicoId.hashCode ^
        observacoes.hashCode;
  }
}
