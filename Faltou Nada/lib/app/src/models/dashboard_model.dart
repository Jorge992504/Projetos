import 'dart:convert';

class DashboardModel {
  DateTime? dateTime;
  String? empresa;
  num? vlTotal;

  DashboardModel({this.dateTime, this.empresa, this.vlTotal});

  DashboardModel copyWith({DateTime? dateTime, String? empresa, num? vlTotal}) {
    return DashboardModel(
      dateTime: dateTime ?? this.dateTime,
      empresa: empresa ?? this.empresa,
      vlTotal: vlTotal ?? this.vlTotal,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'dateTime': dateTime?.toIso8601String(),
      'empresa': empresa,
      'vlTotal': vlTotal,
    };
  }

  factory DashboardModel.fromMap(Map<String, dynamic> map) {
    return DashboardModel(
      dateTime: map['dateTime'] != null
          ? DateTime.parse(map['dateTime'])
          : null,
      empresa: map['empresa'] ?? "",
      vlTotal: map['vlTotal'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory DashboardModel.fromJson(String source) =>
      DashboardModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DashboardModel(dateTime: $dateTime, empresa: $empresa, vlTotal: $vlTotal)';
  }

  @override
  bool operator ==(covariant DashboardModel other) {
    if (identical(this, other)) return true;

    return other.dateTime == dateTime &&
        other.empresa == empresa &&
        other.vlTotal == vlTotal;
  }

  @override
  int get hashCode {
    return dateTime.hashCode ^ empresa.hashCode ^ vlTotal.hashCode;
  }
}
