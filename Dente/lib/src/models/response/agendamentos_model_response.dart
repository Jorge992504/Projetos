// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AgendamentosModelResponse {
  DateTime? data;
  int? id;
  AgendamentosModelResponse({this.data, this.id});

  AgendamentosModelResponse copyWith({DateTime? data, int? id}) {
    return AgendamentosModelResponse(
      data: data ?? this.data,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'data': data?.millisecondsSinceEpoch, 'id': id};
  }

  factory AgendamentosModelResponse.fromMap(Map<String, dynamic> map) {
    return AgendamentosModelResponse(
      data: map['data'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['data'] as int)
          : null,
      id: map['id'] != null ? map['id'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AgendamentosModelResponse.fromJson(String source) =>
      AgendamentosModelResponse.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  @override
  String toString() => 'AgendamentosModelResponse(data: $data, id: $id)';

  @override
  bool operator ==(covariant AgendamentosModelResponse other) {
    if (identical(this, other)) return true;

    return other.data == data && other.id == id;
  }

  @override
  int get hashCode => data.hashCode ^ id.hashCode;
}
