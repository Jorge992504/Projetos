import 'dart:convert';

import 'package:flutter/material.dart';

class EnderecoMod {
  final String cep;
  final String logradouro;
  final String complemento;

  EnderecoMod({
    required this.cep,
    required this.logradouro,
    required this.complemento,
  });

  Map<String, dynamic> toMap() {
    return {'cep': cep, 'logradouro': logradouro, 'complemento': complemento};
  }

  factory EnderecoMod.fromMap(Map<String, dynamic> map) {
    return EnderecoMod(
        cep: map['cep'],
        logradouro: map['logradouro'],
        complemento: map['complemento']);
  }
  factory EnderecoMod.fromJson(String json) =>
      EnderecoMod.fromMap(jsonDecode(json));
}
