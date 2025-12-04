// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CardResponse {
  String? status;
  String? statusDetail;
  int? id;
  DateTime? dateApproved;
  String? paymentMethodId;
  CardResponse({
    this.status,
    this.statusDetail,
    this.id,
    this.dateApproved,
    this.paymentMethodId,
  });

  CardResponse copyWith({
    String? status,
    String? statusDetail,
    int? id,
    DateTime? dateApproved,
    String? paymentMethodId,
  }) {
    return CardResponse(
      status: status ?? this.status,
      statusDetail: statusDetail ?? this.statusDetail,
      id: id ?? this.id,
      dateApproved: dateApproved ?? this.dateApproved,
      paymentMethodId: paymentMethodId ?? this.paymentMethodId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'statusDetail': statusDetail,
      'id': id,
      'dateApproved': dateApproved?.millisecondsSinceEpoch,
      'paymentMethodId': paymentMethodId,
    };
  }

  factory CardResponse.fromMap(Map<String, dynamic> map) {
    return CardResponse(
      status: map['status'] ?? "",
      statusDetail: map['statusDetail'] ?? "",
      id: map['id'] ?? 0,
      dateApproved: map['dateApproved'] != null
          ? DateTime.tryParse(map['dateApproved'].toString())
          : null,

      paymentMethodId: map['paymentMethodId'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory CardResponse.fromJson(String source) =>
      CardResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CardResponse(status: $status, statusDetail: $statusDetail, id: $id, dateApproved: $dateApproved, paymentMethodId: $paymentMethodId)';
  }

  @override
  bool operator ==(covariant CardResponse other) {
    if (identical(this, other)) return true;

    return other.status == status &&
        other.statusDetail == statusDetail &&
        other.id == id &&
        other.dateApproved == dateApproved &&
        other.paymentMethodId == paymentMethodId;
  }

  @override
  int get hashCode {
    return status.hashCode ^
        statusDetail.hashCode ^
        id.hashCode ^
        dateApproved.hashCode ^
        paymentMethodId.hashCode;
  }

  String? paymentTypeId;
}
