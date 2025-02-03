import 'package:equatable/equatable.dart';
import 'package:match/match.dart';
import 'package:reborn/core/modelos/modelo_dias_treino.dart';

part 'dias_treino_state.g.dart';

@match
enum DiasTreinoStateStatus {
  initial,
  loading,
  loaded,
  error,
  success,
  register,
}

class DiasTreinoState extends Equatable {
  final DiasTreinoStateStatus status;

  final List<ModeloDiasTreino> dias;
  final List<ModeloDiasTreino> diasSelecionado;

  const DiasTreinoState({
    required this.status,
    required this.dias,
    required this.diasSelecionado,
  });

  DiasTreinoState copyWith({
    DiasTreinoStateStatus? status,
    List<ModeloDiasTreino>? dias,
    List<ModeloDiasTreino>? diasSelecionado,
  }) {
    return DiasTreinoState(
      status: status ?? this.status,
      dias: dias ?? this.dias,
      diasSelecionado: diasSelecionado ?? this.diasSelecionado,
    );
  }

  @override
  List<Object?> get props => [status, dias];
  DiasTreinoState.initial()
      : status = DiasTreinoStateStatus.initial,
        dias = const [],
        diasSelecionado = [];
}
