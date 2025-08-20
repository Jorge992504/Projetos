import 'package:faltou_nada/app/src/models/dashboard_model.dart';
import 'package:match/match.dart';

part 'dashboard_state.g.dart';

@match
enum DashboardStatus { initial, loading, loaded, success, refresh, failure }

class DashboardState {
  final DashboardStatus status;
  final String? errorMessage;
  final List<DashboardModel>? cabeca;
  final List<DashboardItensModel>? itens;
  DashboardState.initial()
    : status = DashboardStatus.initial,
      errorMessage = null,
      cabeca = [],
      itens = [];
  DashboardState({
    required this.status,
    this.errorMessage,
    this.cabeca,
    this.itens,
  });

  DashboardState copyWith({
    DashboardStatus? status,
    String? errorMessage,
    List<DashboardModel>? cabeca,
    List<DashboardItensModel>? itens,
  }) {
    return DashboardState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      cabeca: cabeca ?? this.cabeca,
      itens: itens ?? this.itens,
    );
  }

  List<Object?> get props {
    return [status, errorMessage, cabeca, itens];
  }
}
