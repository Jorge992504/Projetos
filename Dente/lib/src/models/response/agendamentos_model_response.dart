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
    int? _toEpoch(dynamic value) {
      if (value == null) return null;
      if (value is int) return value;
      if (value is String) {
        final parsedInt = int.tryParse(value);
        if (parsedInt != null) return parsedInt;
        try {
          return DateTime.parse(value).millisecondsSinceEpoch;
        } catch (_) {
          return null;
        }
      }
      return null;
    }

    final epoch = _toEpoch(map['data']);
    return AgendamentosModelResponse(
      data: epoch != null ? DateTime.fromMillisecondsSinceEpoch(epoch) : null,
      id: map['id'] ?? 0,
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
