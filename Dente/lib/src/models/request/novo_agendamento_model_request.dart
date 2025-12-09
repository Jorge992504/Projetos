// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class NovoAgendamentoModelRequest {
  String? dataHora;
  String? cpfPaciente;
  String? observacoes;
  String? nomePaciente;
  String? email;
  int? dentistaId;
  int? servicoId;

  NovoAgendamentoModelRequest({
    this.dataHora,
    this.cpfPaciente,
    this.observacoes,
    this.nomePaciente,
    this.email,
    this.dentistaId,
    this.servicoId,
  });

  NovoAgendamentoModelRequest copyWith({
    String? dataHora,
    String? cpfPaciente,
    String? observacoes,
    String? nomePaciente,
    String? email,
    int? dentistaId,
    int? servicoId,
  }) {
    return NovoAgendamentoModelRequest(
      dataHora: dataHora ?? this.dataHora,
      cpfPaciente: cpfPaciente ?? this.cpfPaciente,
      observacoes: observacoes ?? this.observacoes,
      nomePaciente: nomePaciente ?? this.nomePaciente,
      email: email ?? this.email,
      dentistaId: dentistaId ?? this.dentistaId,
      servicoId: servicoId ?? this.servicoId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'dataHora': dataHora,
      'cpfPaciente': cpfPaciente,
      'observacoes': observacoes,
      'nomePaciente': nomePaciente,
      'email': email,
      'dentistaId': dentistaId,
      'servicoId': servicoId,
    };
  }

  factory NovoAgendamentoModelRequest.fromMap(Map<String, dynamic> map) {
    return NovoAgendamentoModelRequest(
      dataHora: map['dataHora'] ?? "",
      cpfPaciente: map['cpfPaciente'] ?? "",
      observacoes: map['observacoes'] ?? "",
      nomePaciente: map['nomePaciente'] ?? "",
      email: map['email'] ?? "",
      dentistaId: map['dentistaId'] ?? 0,
      servicoId: map['servicoId'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory NovoAgendamentoModelRequest.fromJson(String source) =>
      NovoAgendamentoModelRequest.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  @override
  String toString() {
    return 'NovoAgendamentoModelRequest(dataHora: $dataHora, cpfPaciente: $cpfPaciente, observacoes: $observacoes, nomePaciente: $nomePaciente, email: $email, dentistaId: $dentistaId, servicoId: $servicoId)';
  }

  @override
  bool operator ==(covariant NovoAgendamentoModelRequest other) {
    if (identical(this, other)) return true;

    return other.dataHora == dataHora &&
        other.cpfPaciente == cpfPaciente &&
        other.observacoes == observacoes &&
        other.nomePaciente == nomePaciente &&
        other.email == email &&
        other.dentistaId == dentistaId &&
        other.servicoId == servicoId;
  }

  @override
  int get hashCode {
    return dataHora.hashCode ^
        cpfPaciente.hashCode ^
        observacoes.hashCode ^
        nomePaciente.hashCode ^
        email.hashCode ^
        dentistaId.hashCode ^
        servicoId.hashCode;
  }
}
