abstract class CadastroRepository {
  Future<void> cadastro(
      String usuario,
      String senha,
      String nome,
      String sobrenome,
      double peso,
      double altura,
      String email,
      DateTime nascimento);
}
