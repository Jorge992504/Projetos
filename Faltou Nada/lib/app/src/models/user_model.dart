// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  int idUser;
  String name;
  String email;
  String password;
  UserModel({
    this.idUser = 0,
    this.name = '',
    this.email = '',
    this.password = '',
  });

  UserModel copyWith({
    int? idUser,
    String? name,
    String? email,
    String? password,
  }) {
    return UserModel(
      idUser: idUser ?? this.idUser,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idUser': idUser,
      'name': name,
      'email': email,
      'password': password,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      idUser: map['idUser'] ?? 0,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(idUser: $idUser, name: $name, email: $email, password: $password)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.idUser == idUser &&
        other.name == name &&
        other.email == email &&
        other.password == password;
  }

  @override
  int get hashCode {
    return idUser.hashCode ^ name.hashCode ^ email.hashCode ^ password.hashCode;
  }
}
