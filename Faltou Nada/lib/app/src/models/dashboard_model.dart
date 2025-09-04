// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DashboardModel {
  String? empresa;
  String? data;
  num? vlTotal;
  DashboardModel({this.empresa, this.data, this.vlTotal});

  DashboardModel copyWith({String? empresa, String? data, num? vlTotal}) {
    return DashboardModel(
      empresa: empresa ?? this.empresa,
      data: data ?? this.data,
      vlTotal: vlTotal ?? this.vlTotal,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'empresa': empresa,
      'data': data,
      'vlTotal': vlTotal,
    };
  }

  factory DashboardModel.fromMap(Map<String, dynamic> map) {
    return DashboardModel(
      empresa: map['empresa'] ?? "",
      data: map['data'] ?? "",
      vlTotal: map['vlTotal'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory DashboardModel.fromJson(String source) =>
      DashboardModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'DashboardModel(empresa: $empresa, data: $data, vlTotal: $vlTotal)';

  @override
  bool operator ==(covariant DashboardModel other) {
    if (identical(this, other)) return true;

    return other.empresa == empresa &&
        other.data == data &&
        other.vlTotal == vlTotal;
  }

  @override
  int get hashCode => empresa.hashCode ^ data.hashCode ^ vlTotal.hashCode;
}

class DashboardItensModel {
  String? descricao;
  num? unit;
  num? qtde;
  String? un;
  num? total;
  DashboardItensModel({
    this.descricao,
    this.unit,
    this.qtde,
    this.un,
    this.total,
  });

  DashboardItensModel copyWith({
    String? descricao,
    int? unit,
    num? qtde,
    String? un,
    num? total,
  }) {
    return DashboardItensModel(
      descricao: descricao ?? this.descricao,
      unit: unit ?? this.unit,
      qtde: qtde ?? this.qtde,
      un: un ?? this.un,
      total: total ?? this.total,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'descricao': descricao,
      'unit': unit,
      'qtde': qtde,
      'un': un,
      'total': total,
    };
  }

  factory DashboardItensModel.fromMap(Map<String, dynamic> map) {
    return DashboardItensModel(
      descricao: map['descricao'] ?? "",
      unit: map['unit'] ?? 0,
      qtde: map['qtde'] ?? 0,
      un: map['un'] ?? "",
      total: map['total'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory DashboardItensModel.fromJson(String source) =>
      DashboardItensModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DashboardItensModel(descricao: $descricao, unit: $unit, qtde: $qtde, un: $un, total: $total)';
  }

  @override
  bool operator ==(covariant DashboardItensModel other) {
    if (identical(this, other)) return true;

    return other.descricao == descricao &&
        other.unit == unit &&
        other.qtde == qtde &&
        other.un == un &&
        other.total == total;
  }

  @override
  int get hashCode {
    return descricao.hashCode ^
        unit.hashCode ^
        qtde.hashCode ^
        un.hashCode ^
        total.hashCode;
  }
}
