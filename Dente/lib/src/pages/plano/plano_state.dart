import 'package:match/match.dart';

part 'plano_state.g.dart';

@match
enum PlanoStatus { initial, loading, loaded, success, failure }

class PlanoState {
  final PlanoStatus status;
  final String? errorMessage;

  PlanoState.initial() : status = PlanoStatus.initial, errorMessage = null;
  PlanoState({required this.status, this.errorMessage});

  PlanoState copyWith({PlanoStatus? status, String? errorMessage}) {
    return PlanoState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  List<Object?> get props {
    return [status, errorMessage];
  }
}
