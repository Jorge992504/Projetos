// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:activovo/core/models/exercicio.dart';
import 'package:equatable/equatable.dart';
import 'package:match/match.dart';

@match
enum StateStatus {
  initial,
  loading,
  loaded,
  error,
}

class Status extends Equatable {
  final StateStatus status;
  final String? errorMessage;
  final List<Exercicio> exercicio;

  const Status(
      {required this.status,
      required this.errorMessage,
      required this.exercicio});

  Status copyWith({
    StateStatus? status,
    String? errorMesage,
    List<Exercicio>? exercicio,
  }) {
    return Status(
      status: status ?? this.status,
      errorMessage: errorMesage ?? errorMessage,
      exercicio: exercicio ?? this.exercicio,
    );
  }

  @override
  List<Object> get props => [status];

  const Status.initial()
      : status = StateStatus.initial,
        errorMessage = null,
        exercicio = const [];
}
