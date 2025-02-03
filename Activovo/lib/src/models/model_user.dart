class ModelUser {
  final int id;
  final String name;
  final String email;
  final String password;
  final String profile;
  ModelUser({
    required this.id,
    required this.name,
    required this.email,
    required this.profile,
    required this.password,
  });

  factory ModelUser.fromMap(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'name': String name,
        'email': String email,
        'profile': String profile,
        'password': String password,
      } =>
        ModelUser(
          id: id,
          name: name,
          email: email,
          profile: profile,
          password: password,
        ),
      _ => throw ArgumentError('Invalid Json'),
    };
  }
}
