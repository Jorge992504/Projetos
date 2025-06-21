// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AuthModel {
  String token;
  String email;
  String name;
  AuthModel({
    this.token = '',
    this.email = '',
    this.name = '',
  });

  AuthModel copyWith({
    String? token,
    String? email,
    String? name,
  }) {
    return AuthModel(
      token: token ?? this.token,
      email: email ?? this.email,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'token': token,
      'email': email,
      'name': name,
    };
  }

  factory AuthModel.fromMap(Map<String, dynamic> map) {
    return AuthModel(
      token: map['token'] ?? '',
      email: map['email'] ?? '',
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthModel.fromJson(String source) =>
      AuthModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'AuthModel(token: $token, email: $email, name: $name)';

  @override
  bool operator ==(covariant AuthModel other) {
    if (identical(this, other)) return true;

    return other.token == token && other.email == email && other.name == name;
  }

  @override
  int get hashCode => token.hashCode ^ email.hashCode ^ name.hashCode;
}
