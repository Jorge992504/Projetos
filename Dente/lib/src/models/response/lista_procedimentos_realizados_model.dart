// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ListaProcedimentosRealizadosModel {
  String? servico;
  int? quantidade;
  double? percentual;
  ListaProcedimentosRealizadosModel({
    this.servico,
    this.quantidade,
    this.percentual,
  });

  ListaProcedimentosRealizadosModel copyWith({
    String? servico,
    int? quantidade,
    double? percentual,
  }) {
    return ListaProcedimentosRealizadosModel(
      servico: servico ?? this.servico,
      quantidade: quantidade ?? this.quantidade,
      percentual: percentual ?? this.percentual,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'servico': servico,
      'quantidade': quantidade,
      'percentual': percentual,
    };
  }

  factory ListaProcedimentosRealizadosModel.fromMap(Map<String, dynamic> map) {
    return ListaProcedimentosRealizadosModel(
      servico: map['servico'] ?? "",
      quantidade: map['quantidade'] ?? 0,
      percentual: map['percentual'] ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ListaProcedimentosRealizadosModel.fromJson(String source) =>
      ListaProcedimentosRealizadosModel.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  @override
  String toString() =>
      'ListaProcedimentosRealizadosModel(servico: $servico, quantidade: $quantidade, percentual: $percentual)';

  @override
  bool operator ==(covariant ListaProcedimentosRealizadosModel other) {
    if (identical(this, other)) return true;

    return other.servico == servico &&
        other.quantidade == quantidade &&
        other.percentual == percentual;
  }

  @override
  int get hashCode =>
      servico.hashCode ^ quantidade.hashCode ^ percentual.hashCode;
}
