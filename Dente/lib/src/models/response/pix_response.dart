// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PixResponse {
  String? qrCodeBase64;
  String? qrCode;
  int? paymentId;
  PixResponse({this.qrCodeBase64, this.qrCode, this.paymentId});

  PixResponse copyWith({String? qrCodeBase64, String? qrCode, int? paymentId}) {
    return PixResponse(
      qrCodeBase64: qrCodeBase64 ?? this.qrCodeBase64,
      qrCode: qrCode ?? this.qrCode,
      paymentId: paymentId ?? this.paymentId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'qrCodeBase64': qrCodeBase64,
      'qrCode': qrCode,
      'paymentId': paymentId,
    };
  }

  factory PixResponse.fromMap(Map<String, dynamic> map) {
    return PixResponse(
      qrCodeBase64: map['qrCodeBase64'] ?? "",
      qrCode: map['qrCode'] ?? "",
      paymentId: map['paymentId'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory PixResponse.fromJson(String source) =>
      PixResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'PixResponse(qrCodeBase64: $qrCodeBase64, qrCode: $qrCode, paymentId: $paymentId)';

  @override
  bool operator ==(covariant PixResponse other) {
    if (identical(this, other)) return true;

    return other.qrCodeBase64 == qrCodeBase64 &&
        other.qrCode == qrCode &&
        other.paymentId == paymentId;
  }

  @override
  int get hashCode =>
      qrCodeBase64.hashCode ^ qrCode.hashCode ^ paymentId.hashCode;
}
