// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ListarConveniosResponse {
  String? parceiro;
  String? tratamento;
  num? valor_pago;
  ListarConveniosResponse({this.parceiro, this.tratamento, this.valor_pago});

  ListarConveniosResponse copyWith({
    String? parceiro,
    String? tratamento,
    num? valor_pago,
  }) {
    return ListarConveniosResponse(
      parceiro: parceiro ?? this.parceiro,
      tratamento: tratamento ?? this.tratamento,
      valor_pago: valor_pago ?? this.valor_pago,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'parceiro': parceiro,
      'tratamento': tratamento,
      'valor_pago': valor_pago,
    };
  }

  factory ListarConveniosResponse.fromMap(Map<String, dynamic> map) {
    return ListarConveniosResponse(
      parceiro: map['parceiro'] ?? "",
      tratamento: map['tratamento'] ?? "",
      valor_pago: map['valor_pago'] ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ListarConveniosResponse.fromJson(String source) =>
      ListarConveniosResponse.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  @override
  String toString() =>
      'ListarConveniosResponse(parceiro: $parceiro, tratamento: $tratamento, valor_pago: $valor_pago)';

  @override
  bool operator ==(covariant ListarConveniosResponse other) {
    if (identical(this, other)) return true;

    return other.parceiro == parceiro &&
        other.tratamento == tratamento &&
        other.valor_pago == valor_pago;
  }

  @override
  int get hashCode =>
      parceiro.hashCode ^ tratamento.hashCode ^ valor_pago.hashCode;
}
