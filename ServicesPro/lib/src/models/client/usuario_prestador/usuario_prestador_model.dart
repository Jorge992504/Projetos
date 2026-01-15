// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UsuarioPrestadorModel {
  int? usuarioId;
  String? usuarioNome;
  int? categoriaId;
  String? categoriaNome;
  num? avaliaca;
  UsuarioPrestadorModel({
    this.usuarioId,
    this.usuarioNome,
    this.categoriaId,
    this.categoriaNome,
    this.avaliaca,
  });

  UsuarioPrestadorModel copyWith({
    int? usuarioId,
    String? usuarioNome,
    int? categoriaId,
    String? categoriaNome,
    num? avaliaca,
  }) {
    return UsuarioPrestadorModel(
      usuarioId: usuarioId ?? this.usuarioId,
      usuarioNome: usuarioNome ?? this.usuarioNome,
      categoriaId: categoriaId ?? this.categoriaId,
      categoriaNome: categoriaNome ?? this.categoriaNome,
      avaliaca: avaliaca ?? this.avaliaca,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'usuarioId': usuarioId,
      'usuarioNome': usuarioNome,
      'categoriaId': categoriaId,
      'categoriaNome': categoriaNome,
      'avaliaca': avaliaca,
    };
  }

  factory UsuarioPrestadorModel.fromMap(Map<String, dynamic> map) {
    return UsuarioPrestadorModel(
      usuarioId: map['usuarioId'] != null ? map['usuarioId'] as int : null,
      usuarioNome: map['usuarioNome'] != null
          ? map['usuarioNome'] as String
          : null,
      categoriaId: map['categoriaId'] != null
          ? map['categoriaId'] as int
          : null,
      categoriaNome: map['categoriaNome'] != null
          ? map['categoriaNome'] as String
          : null,
      avaliaca: map['avaliaca'] != null ? map['avaliaca'] as num : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UsuarioPrestadorModel.fromJson(String source) =>
      UsuarioPrestadorModel.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  @override
  String toString() {
    return 'UsuarioPrestadorModel(usuarioId: $usuarioId, usuarioNome: $usuarioNome, categoriaId: $categoriaId, categoriaNome: $categoriaNome, avaliaca: $avaliaca)';
  }

  @override
  bool operator ==(covariant UsuarioPrestadorModel other) {
    if (identical(this, other)) return true;

    return other.usuarioId == usuarioId &&
        other.usuarioNome == usuarioNome &&
        other.categoriaId == categoriaId &&
        other.categoriaNome == categoriaNome &&
        other.avaliaca == avaliaca;
  }

  @override
  int get hashCode {
    return usuarioId.hashCode ^
        usuarioNome.hashCode ^
        categoriaId.hashCode ^
        categoriaNome.hashCode ^
        avaliaca.hashCode;
  }
}
