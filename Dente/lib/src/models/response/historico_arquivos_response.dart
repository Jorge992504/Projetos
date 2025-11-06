// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class HistoricoArquivosResponse {
  final String data;
  final List<String> arquivos;
  HistoricoArquivosResponse({required this.data, required this.arquivos});

  HistoricoArquivosResponse copyWith({String? data, List<String>? arquivos}) {
    return HistoricoArquivosResponse(
      data: data ?? this.data,
      arquivos: arquivos ?? this.arquivos,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'data': data, 'arquivos': arquivos};
  }

  factory HistoricoArquivosResponse.fromMap(Map<String, dynamic> map) {
    return HistoricoArquivosResponse(
      data: map['data'] ?? "",
      arquivos: List<String>.from((map['arquivos'] ?? [])),
    );
  }

  String toJson() => json.encode(toMap());

  factory HistoricoArquivosResponse.fromJson(String source) =>
      HistoricoArquivosResponse.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  @override
  String toString() =>
      'HistoricoArquivosResponse(data: $data, arquivos: $arquivos)';

  @override
  bool operator ==(covariant HistoricoArquivosResponse other) {
    if (identical(this, other)) return true;

    return other.data == data && listEquals(other.arquivos, arquivos);
  }

  @override
  int get hashCode => data.hashCode ^ arquivos.hashCode;
}
