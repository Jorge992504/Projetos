// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ResponseToken {
  final String token;
  ResponseToken({required this.token});

  ResponseToken copyWith({String? token}) {
    return ResponseToken(token: token ?? this.token);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'token': token};
  }

  factory ResponseToken.fromMap(Map<String, dynamic> map) {
    return ResponseToken(token: map['token'] ?? "");
  }

  String toJson() => json.encode(toMap());

  factory ResponseToken.fromJson(String source) =>
      ResponseToken.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ResponseToken(token: $token)';

  @override
  bool operator ==(covariant ResponseToken other) {
    if (identical(this, other)) return true;

    return other.token == token;
  }

  @override
  int get hashCode => token.hashCode;
}
