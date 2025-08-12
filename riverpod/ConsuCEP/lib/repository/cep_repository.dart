import 'dart:convert';

import 'package:consucep/models/cep_model.dart';
import 'package:http/http.dart' as http;

class CepRepository {
  static const String _baseUrl = 'https://viacep.com.br/ws/';
  final http.Client client;

  CepRepository({required this.client});

  Future<CepModel> consultarCep(String cep) async {
    //tirar a mask
    final cleanCep = cep.replaceAll(r'[^0-9]', '');
    if (cleanCep.length != 8) {
      throw Exception('CEP deve conter exatamente 8 digitos');
    }

    final url = Uri.parse('$_baseUrl$cleanCep/json');

    try {
      final reponse = await client.get(url);
      if (reponse.statusCode == 200) {
        final jsonData = json.decode(reponse.body);
        if (jsonData.containsKey('erro')) {
          throw Exception('CEP não encontrado');
        }
        return CepModel.fromJson(jsonData);
      } else {
        throw Exception('Erro na requisição');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
