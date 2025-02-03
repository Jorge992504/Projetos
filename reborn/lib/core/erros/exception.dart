class ExceptionErros implements Exception {
  final String message;
  ExceptionErros({required this.message});
}

class ExceptionSuccess implements Exception {
  final String message;
  ExceptionSuccess({required this.message});
}
