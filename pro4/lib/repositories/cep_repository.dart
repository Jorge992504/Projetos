import 'package:cep_app/models/endereco_mod.dart';

abstract class CepRepository {
  Future<EnderecoMod> getCep(String cep);
}
