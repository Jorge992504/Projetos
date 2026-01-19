// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ResponseMessageModel {
  int? usuarioFrom;
  String? message;
  ResponseMessageModel({this.usuarioFrom, this.message});

  ResponseMessageModel copyWith({int? usuarioFrom, String? message}) {
    return ResponseMessageModel(
      usuarioFrom: usuarioFrom ?? this.usuarioFrom,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'usuarioFrom': usuarioFrom, 'message': message};
  }

  factory ResponseMessageModel.fromMap(Map<String, dynamic> map) {
    return ResponseMessageModel(
      usuarioFrom: map['usuarioFrom'] != null
          ? map['usuarioFrom'] as int
          : null,
      message: map['message'] != null ? map['message'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ResponseMessageModel.fromJson(String source) =>
      ResponseMessageModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ResponseMessageModel(usuarioFrom: $usuarioFrom, message: $message)';

  @override
  bool operator ==(covariant ResponseMessageModel other) {
    if (identical(this, other)) return true;

    return other.usuarioFrom == usuarioFrom && other.message == message;
  }

  @override
  int get hashCode => usuarioFrom.hashCode ^ message.hashCode;
}
