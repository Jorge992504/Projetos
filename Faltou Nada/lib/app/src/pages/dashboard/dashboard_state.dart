import 'package:faltou_nada/app/src/models/dashboard_model.dart';
import 'package:match/match.dart';

part 'dashboard_state.g.dart';

@match
enum DashboardStatus { initial, loading, loaded, success, refresh, failure }

class DashboardState {
  final DashboardStatus status;
  final String? errorMessage;
  final List<DashboardModel>? cabeca;
  DashboardState.initial()
    : status = DashboardStatus.initial,
      errorMessage = null,
      cabeca = [];
  DashboardState({required this.status, this.errorMessage, this.cabeca});

  DashboardState copyWith({
    DashboardStatus? status,
    String? errorMessage,
    List<DashboardModel>? cabeca,
  }) {
    return DashboardState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      cabeca: cabeca ?? this.cabeca,
    );
  }

  List<Object?> get props {
    return [status, errorMessage, cabeca];
  }
}
