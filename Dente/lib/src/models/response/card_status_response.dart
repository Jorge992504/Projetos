// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CardStatusResponse {
  String? status;
  CardStatusResponse({this.status});

  CardStatusResponse copyWith({String? status}) {
    return CardStatusResponse(status: status ?? this.status);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'status': status};
  }

  factory CardStatusResponse.fromMap(Map<String, dynamic> map) {
    return CardStatusResponse(status: map['status'] ?? "");
  }

  String toJson() => json.encode(toMap());

  factory CardStatusResponse.fromJson(String source) =>
      CardStatusResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CardStatusResponse(status: $status)';

  @override
  bool operator ==(covariant CardStatusResponse other) {
    if (identical(this, other)) return true;

    return other.status == status;
  }

  @override
  int get hashCode => status.hashCode;
}
