// ignore_for_file: public_member_api_docs, sort_constructors_first

class RepositoryExeception implements Exception {
  final String message;
  RepositoryExeception({
    required this.message,
  });
}
