import 'package:dente/src/models/dentista_model.dart';
import 'package:match/match.dart';

part 'dentista_state.g.dart';

@match
enum DentistaStatus { initial, loading, loaded, success, failure }

class DentistaState {
  final DentistaStatus status;
  final String? errorMessage;
  final List<DentistaModel>? dentistas;

  DentistaState.initial()
    : status = DentistaStatus.initial,
      errorMessage = null,
      dentistas = null;
  DentistaState({required this.status, this.errorMessage, this.dentistas});

  DentistaState copyWith({
    DentistaStatus? status,
    String? errorMessage,
    List<DentistaModel>? dentistas,
  }) {
    return DentistaState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      dentistas: dentistas ?? this.dentistas,
    );
  }

  List<Object?> get props {
    return [status, errorMessage, dentistas];
  }
}
