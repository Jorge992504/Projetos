// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  final int id;
  final String name;
  final String email;
  final String password;
  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
  });

  factory UserModel.fromMap(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'name': String name,
        'email': String email,
        'password': String password,
      } =>
        UserModel(
          id: id,
          name: name,
          email: email,
          password: password,
        ),
      _ => throw ArgumentError('Invalid JSON UserModel'),
    };
  }
}
