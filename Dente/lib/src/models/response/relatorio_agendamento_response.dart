// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class RelatorioAgendamentoResponse {
  String? servico;
  String? data;
  String? hora;
  String? status;
  RelatorioAgendamentoResponse({
    this.servico,
    this.data,
    this.hora,
    this.status,
  });

  RelatorioAgendamentoResponse copyWith({
    String? servico,
    String? data,
    String? hora,
    String? status,
  }) {
    return RelatorioAgendamentoResponse(
      servico: servico ?? this.servico,
      data: data ?? this.data,
      hora: hora ?? this.hora,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'servico': servico,
      'data': data,
      'hora': hora,
      'status': status,
    };
  }

  factory RelatorioAgendamentoResponse.fromMap(Map<String, dynamic> map) {
    return RelatorioAgendamentoResponse(
      servico: map['servico'] ?? "",
      data: map['data'] ?? "",
      hora: map['hora'] ?? "",
      status: map['status'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory RelatorioAgendamentoResponse.fromJson(String source) =>
      RelatorioAgendamentoResponse.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  @override
  String toString() {
    return 'RelatorioAgendamentoResponse(servico: $servico, data: $data, hora: $hora, status: $status)';
  }

  @override
  bool operator ==(covariant RelatorioAgendamentoResponse other) {
    if (identical(this, other)) return true;

    return other.servico == servico &&
        other.data == data &&
        other.hora == hora &&
        other.status == status;
  }

  @override
  int get hashCode {
    return servico.hashCode ^ data.hashCode ^ hora.hashCode ^ status.hashCode;
  }
}
