// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class RequestMessageModel {
  int? usuarioFrom;
  int? usuarioTo;
  String? message;
  RequestMessageModel({this.usuarioFrom, this.usuarioTo, this.message});

  RequestMessageModel copyWith({
    int? usuarioFrom,
    int? usuarioTo,
    String? message,
  }) {
    return RequestMessageModel(
      usuarioFrom: usuarioFrom ?? this.usuarioFrom,
      usuarioTo: usuarioTo ?? this.usuarioTo,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'usuarioFrom': usuarioFrom,
      'usuarioTo': usuarioTo,
      'message': message,
    };
  }

  factory RequestMessageModel.fromMap(Map<String, dynamic> map) {
    return RequestMessageModel(
      usuarioFrom: map['usuarioFrom'] != null
          ? map['usuarioFrom'] as int
          : null,
      usuarioTo: map['usuarioTo'] != null ? map['usuarioTo'] as int : null,
      message: map['message'] != null ? map['message'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RequestMessageModel.fromJson(String source) =>
      RequestMessageModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'RequestMessageModel(usuarioFrom: $usuarioFrom, usuarioTo: $usuarioTo, message: $message)';

  @override
  bool operator ==(covariant RequestMessageModel other) {
    if (identical(this, other)) return true;

    return other.usuarioFrom == usuarioFrom &&
        other.usuarioTo == usuarioTo &&
        other.message == message;
  }

  @override
  int get hashCode =>
      usuarioFrom.hashCode ^ usuarioTo.hashCode ^ message.hashCode;
}
