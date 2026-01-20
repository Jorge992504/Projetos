// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class NotificacaoResponse {
  int? usuarioId;
  String? usuarioNome;
  NotificacaoResponse({this.usuarioId, this.usuarioNome});

  NotificacaoResponse copyWith({int? usuarioId, String? usuarioNome}) {
    return NotificacaoResponse(
      usuarioId: usuarioId ?? this.usuarioId,
      usuarioNome: usuarioNome ?? this.usuarioNome,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'usuarioId': usuarioId,
      'usuarioNome': usuarioNome,
    };
  }

  factory NotificacaoResponse.fromMap(Map<String, dynamic> map) {
    return NotificacaoResponse(
      usuarioId: map['usuarioId'] != null ? map['usuarioId'] as int : null,
      usuarioNome: map['usuarioNome'] != null
          ? map['usuarioNome'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificacaoResponse.fromJson(String source) =>
      NotificacaoResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'NotificacaoResponse(usuarioId: $usuarioId, usuarioNome: $usuarioNome)';

  @override
  bool operator ==(covariant NotificacaoResponse other) {
    if (identical(this, other)) return true;

    return other.usuarioId == usuarioId && other.usuarioNome == usuarioNome;
  }

  @override
  int get hashCode => usuarioId.hashCode ^ usuarioNome.hashCode;
}
