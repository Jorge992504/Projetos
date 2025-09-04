// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class RegisterUserModel {
  String? email;
  String? password;
  String? name;
  RegisterUserModel({this.email, this.password, this.name});

  RegisterUserModel copyWith({String? email, String? password, String? name}) {
    return RegisterUserModel(
      email: email ?? this.email,
      password: password ?? this.password,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
      'name': name,
    };
  }

  factory RegisterUserModel.fromMap(Map<String, dynamic> map) {
    return RegisterUserModel(
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory RegisterUserModel.fromJson(String source) =>
      RegisterUserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'RegisterUserModel(email: $email, password: $password, name: $name)';

  @override
  bool operator ==(covariant RegisterUserModel other) {
    if (identical(this, other)) return true;

    return other.email == email &&
        other.password == password &&
        other.name == name;
  }

  @override
  int get hashCode => email.hashCode ^ password.hashCode ^ name.hashCode;
}
