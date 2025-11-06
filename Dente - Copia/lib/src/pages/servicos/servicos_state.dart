import 'package:dente/src/models/servicos_model.dart';
import 'package:match/match.dart';

part 'servicos_state.g.dart';

@match
enum ServicosStatus { initial, loading, loaded, success, failure }

class ServicosState {
  final ServicosStatus status;
  final String? errorMessage;
  final List<ServicosModel>? servicos;

  ServicosState.initial()
    : status = ServicosStatus.initial,
      errorMessage = null,
      servicos = null;
  ServicosState({required this.status, this.errorMessage, this.servicos});

  ServicosState copyWith({
    ServicosStatus? status,
    String? errorMessage,
    List<ServicosModel>? servicos,
  }) {
    return ServicosState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      servicos: servicos ?? this.servicos,
    );
  }

  List<Object?> get props {
    return [status, errorMessage, servicos];
  }
}
