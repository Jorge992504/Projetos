// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UsuarioPrestadorModel {
  int? usuarioId;
  String? usuarioNome;
  int? categoriaId;
  String? categoriaNome;
  num? avaliacao;
  String? foto;
  UsuarioPrestadorModel({
    this.usuarioId,
    this.usuarioNome,
    this.categoriaId,
    this.categoriaNome,
    this.avaliacao,
    this.foto,
  });

  UsuarioPrestadorModel copyWith({
    int? usuarioId,
    String? usuarioNome,
    int? categoriaId,
    String? categoriaNome,
    num? avaliacao,
    String? foto,
  }) {
    return UsuarioPrestadorModel(
      usuarioId: usuarioId ?? this.usuarioId,
      usuarioNome: usuarioNome ?? this.usuarioNome,
      categoriaId: categoriaId ?? this.categoriaId,
      categoriaNome: categoriaNome ?? this.categoriaNome,
      avaliacao: avaliacao ?? this.avaliacao,
      foto: foto ?? this.foto,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'usuarioId': usuarioId,
      'usuarioNome': usuarioNome,
      'categoriaId': categoriaId,
      'categoriaNome': categoriaNome,
      'avaliacao': avaliacao,
      'foto': foto,
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
      avaliacao: map['avaliacao'] != null ? map['avaliacao'] as num : null,
      foto: map['foto'] != null ? map['foto'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UsuarioPrestadorModel.fromJson(String source) =>
      UsuarioPrestadorModel.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  @override
  String toString() {
    return 'UsuarioPrestadorModel(usuarioId: $usuarioId, usuarioNome: $usuarioNome, categoriaId: $categoriaId, categoriaNome: $categoriaNome, avaliacao: $avaliacao, foto: $foto)';
  }

  @override
  bool operator ==(covariant UsuarioPrestadorModel other) {
    if (identical(this, other)) return true;

    return other.usuarioId == usuarioId &&
        other.usuarioNome == usuarioNome &&
        other.categoriaId == categoriaId &&
        other.categoriaNome == categoriaNome &&
        other.avaliacao == avaliacao &&
        other.foto == foto;
  }

  @override
  int get hashCode {
    return usuarioId.hashCode ^
        usuarioNome.hashCode ^
        categoriaId.hashCode ^
        categoriaNome.hashCode ^
        avaliacao.hashCode ^
        foto.hashCode;
  }
}
