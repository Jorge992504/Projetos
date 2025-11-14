import 'package:dente/src/models/request/lista_relatorios_model.dart';
import 'package:match/match.dart';

part 'dashboard_state.g.dart';

@match
enum DashboardStatus { initial, loading, loaded, success, failure }

class DashboardState {
  final DashboardStatus status;
  final String? errorMessage;
  final List<ListaRelatoriosModel>? relatorios;

  DashboardState.initial()
    : status = DashboardStatus.initial,
      errorMessage = null,
      relatorios = [];
  DashboardState({required this.status, this.errorMessage, this.relatorios});

  DashboardState copyWith({
    DashboardStatus? status,
    String? errorMessage,
    List<ListaRelatoriosModel>? relatorios,
  }) {
    return DashboardState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      relatorios: relatorios ?? this.relatorios,
    );
  }

  List<Object?> get props {
    return [status, errorMessage, relatorios];
  }
}
