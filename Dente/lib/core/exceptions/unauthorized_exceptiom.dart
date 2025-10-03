class UnauthorizedExceptiom implements Exception {
  final String message;

  UnauthorizedExceptiom([this.message = 'Usuário ou senha inválidos']);

  @override
  String toString() {
    return message;
  }
}
