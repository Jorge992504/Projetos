import 'package:cep_app/models/endereco_mod.dart';
import 'package:cep_app/repositories/cep_repository.dart';
import 'package:dio/dio.dart';

class CepRepositoryImpl implements CepRepository {
  @override
  Future<EnderecoMod> getCep(String cep) async {
    final result = await Dio().get('https://viacep.com.br/ws/$cep/json/');
    return EnderecoMod.fromMap(result.data);
  }
}
