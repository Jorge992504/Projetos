// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AuthModel {
  String token;
  String msg;
  AuthModel({
    this.token = '',
    this.msg = '',
  });

  AuthModel copyWith({
    String? token,
    String? msg,
  }) {
    return AuthModel(
      token: token ?? this.token,
      msg: msg ?? this.msg,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'token': token,
      'msg': msg,
    };
  }

  factory AuthModel.fromMap(Map<String, dynamic> map) {
    return AuthModel(
      token: map['token'] ?? '',
      msg: map['msg'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthModel.fromJson(String source) =>
      AuthModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'AuthModel(token: $token, msg: $msg,)';

  @override
  bool operator ==(covariant AuthModel other) {
    if (identical(this, other)) return true;

    return other.token == token && other.msg == msg;
  }

  @override
  int get hashCode => token.hashCode ^ msg.hashCode;
}
