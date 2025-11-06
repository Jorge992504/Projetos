import 'dart:convert';

class AgendamentoPorPacienteRequest {
  String? data;
  int? id;
  AgendamentoPorPacienteRequest({this.data, this.id});

  AgendamentoPorPacienteRequest copyWith({String? data, int? id}) {
    return AgendamentoPorPacienteRequest(
      data: data ?? this.data,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'data': data, 'id': id};
  }

  factory AgendamentoPorPacienteRequest.fromMap(Map<String, dynamic> map) {
    return AgendamentoPorPacienteRequest(
      data: map['data'] != null ? map['data'] as String : null,
      id: map['id'] != null ? map['id'] as int : null,
    );
  }

  // String toJson() => json.encode(toMap());
  Map<String, dynamic> toJson() => toMap();

  factory AgendamentoPorPacienteRequest.fromJson(String source) =>
      AgendamentoPorPacienteRequest.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  @override
  String toString() => 'AgendamentoPorPacienteRequest(data: $data, id: $id)';

  @override
  bool operator ==(covariant AgendamentoPorPacienteRequest other) {
    if (identical(this, other)) return true;

    return other.data == data && other.id == id;
  }

  @override
  int get hashCode => data.hashCode ^ id.hashCode;
}
