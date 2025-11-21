// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ConvenioModel {
  String? parceiro;
  int? tratamento;
  num? valorPago;
  ConvenioModel({this.parceiro, this.tratamento, this.valorPago});

  ConvenioModel copyWith({String? parceiro, int? tratamento, num? valorPago}) {
    return ConvenioModel(
      parceiro: parceiro ?? this.parceiro,
      tratamento: tratamento ?? this.tratamento,
      valorPago: valorPago ?? this.valorPago,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'parceiro': parceiro,
      'tratamento': tratamento,
      'valorPago': valorPago,
    };
  }

  factory ConvenioModel.fromMap(Map<String, dynamic> map) {
    return ConvenioModel(
      parceiro: map['parceiro'] ?? "",
      tratamento: map['tratamento'] ?? "",
      valorPago: map['valorPago'] ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ConvenioModel.fromJson(String source) =>
      ConvenioModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ConvenioModel(parceiro: $parceiro, tratamento: $tratamento, valorPago: $valorPago)';

  @override
  bool operator ==(covariant ConvenioModel other) {
    if (identical(this, other)) return true;

    return other.parceiro == parceiro &&
        other.tratamento == tratamento &&
        other.valorPago == valorPago;
  }

  @override
  int get hashCode =>
      parceiro.hashCode ^ tratamento.hashCode ^ valorPago.hashCode;
}
