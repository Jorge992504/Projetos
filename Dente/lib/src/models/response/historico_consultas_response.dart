// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class HistoricoConsultasResponse {
  String? dataHora;
  String? nomePaciente;
  String? status;
  String? servico;
  String? atendimento;
  HistoricoConsultasResponse({
    this.dataHora,
    this.nomePaciente,
    this.status,
    this.servico,
    this.atendimento,
  });

  HistoricoConsultasResponse copyWith({
    String? dataHora,
    String? nomePaciente,
    String? status,
    String? servico,
    String? atendimento,
  }) {
    return HistoricoConsultasResponse(
      dataHora: dataHora ?? this.dataHora,
      nomePaciente: nomePaciente ?? this.nomePaciente,
      status: status ?? this.status,
      servico: servico ?? this.servico,
      atendimento: atendimento ?? this.atendimento,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'dataHora': dataHora,
      'nomePaciente': nomePaciente,
      'status': status,
      'servico': servico,
      'atendimento': atendimento,
    };
  }

  factory HistoricoConsultasResponse.fromMap(Map<String, dynamic> map) {
    return HistoricoConsultasResponse(
      dataHora: map['dataHora'] ?? "",
      nomePaciente: map['nomePaciente'] ?? "",
      status: map['status'] ?? "",
      servico: map['servico'] ?? "",
      atendimento: map['atendimento'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory HistoricoConsultasResponse.fromJson(String source) =>
      HistoricoConsultasResponse.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  @override
  String toString() {
    return 'HistoricoConsultasResponse(dataHora: $dataHora, nomePaciente: $nomePaciente, status: $status, servico: $servico, atendimento: $atendimento)';
  }

  @override
  bool operator ==(covariant HistoricoConsultasResponse other) {
    if (identical(this, other)) return true;

    return other.dataHora == dataHora &&
        other.nomePaciente == nomePaciente &&
        other.status == status &&
        other.servico == servico &&
        other.atendimento == atendimento;
  }

  @override
  int get hashCode {
    return dataHora.hashCode ^
        nomePaciente.hashCode ^
        status.hashCode ^
        servico.hashCode ^
        atendimento.hashCode;
  }
}
