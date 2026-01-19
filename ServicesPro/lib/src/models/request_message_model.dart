// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class RequestMessageModel {
  int? usuarioTo;
  String? message;
  String? foto;
  RequestMessageModel({this.usuarioTo, this.message, this.foto});

  RequestMessageModel copyWith({
    int? usuarioTo,
    String? message,
    String? foto,
  }) {
    return RequestMessageModel(
      usuarioTo: usuarioTo ?? this.usuarioTo,
      message: message ?? this.message,
      foto: foto ?? this.foto,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'usuarioTo': usuarioTo,
      'message': message,
      'foto': foto,
    };
  }

  factory RequestMessageModel.fromMap(Map<String, dynamic> map) {
    return RequestMessageModel(
      usuarioTo: map['usuarioTo'] != null ? map['usuarioTo'] as int : null,
      message: map['message'] != null ? map['message'] as String : null,
      foto: map['foto'] != null ? map['foto'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RequestMessageModel.fromJson(String source) =>
      RequestMessageModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'RequestMessageModel(usuarioTo: $usuarioTo, message: $message, foto: $foto)';

  @override
  bool operator ==(covariant RequestMessageModel other) {
    if (identical(this, other)) return true;

    return other.usuarioTo == usuarioTo &&
        other.message == message &&
        other.foto == foto;
  }

  @override
  int get hashCode => usuarioTo.hashCode ^ message.hashCode ^ foto.hashCode;
}
