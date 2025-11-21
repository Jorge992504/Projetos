// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class BuscarConveniosPagamentoResponse {
  int? id;
  String? parceiro;
  BuscarConveniosPagamentoResponse({this.id, this.parceiro});

  BuscarConveniosPagamentoResponse copyWith({int? id, String? parceiro}) {
    return BuscarConveniosPagamentoResponse(
      id: id ?? this.id,
      parceiro: parceiro ?? this.parceiro,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'id': id, 'parceiro': parceiro};
  }

  factory BuscarConveniosPagamentoResponse.fromMap(Map<String, dynamic> map) {
    return BuscarConveniosPagamentoResponse(
      id: map['id'] ?? 0,
      parceiro: map['parceiro'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory BuscarConveniosPagamentoResponse.fromJson(String source) =>
      BuscarConveniosPagamentoResponse.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  @override
  String toString() =>
      'BuscarConveniosPagamentoResponse(id: $id, parceiro: $parceiro)';

  @override
  bool operator ==(covariant BuscarConveniosPagamentoResponse other) {
    if (identical(this, other)) return true;

    return other.id == id && other.parceiro == parceiro;
  }

  @override
  int get hashCode => id.hashCode ^ parceiro.hashCode;
}
