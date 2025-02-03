import 'dart:convert';

class ModeloLogin {
  final String token;
  final String refreshToken;
  final String usuario;
  ModeloLogin({
    required this.token,
    required this.refreshToken,
    required this.usuario,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'token': token,
      'refreshToken': refreshToken,
      'usuario': usuario,
    };
  }

  factory ModeloLogin.fromMap(Map<String, dynamic> map) {
    return ModeloLogin(
      token: map['token'] ?? '',
      refreshToken: map['refreshToken'] ?? '',
      usuario: map['usuario'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ModeloLogin.fromJson(String source) =>
      ModeloLogin.fromMap(json.decode(source));
}
