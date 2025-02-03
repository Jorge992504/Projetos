import 'package:equatable/equatable.dart';
import 'package:match/match.dart';
import 'package:reborn/core/modelos/modelo_dias_treino.dart';
import 'package:reborn/core/modelos/modelo_doenca.dart';

part 'doenca_state.g.dart';

@match
enum DoencaStateStatus {
  initial,
  loading,
  loaded,
  error,
  success,
  register,
}

class DoencaState extends Equatable {
  final DoencaStateStatus status;

  final List<ModeloDoenca> doenca;
  final List<ModeloDoenca> doencaSelecionado;

  final List<ModeloDiasTreino> dias;
  final List<ModeloDiasTreino> diasSelecionado;

  const DoencaState({
    required this.status,
    required this.doenca,
    required this.doencaSelecionado,
    required this.dias,
    required this.diasSelecionado,
  });

  DoencaState copyWith({
    DoencaStateStatus? status,
    List<ModeloDoenca>? doenca,
    List<ModeloDoenca>? doencaSelecionado,
    List<ModeloDiasTreino>? dias,
    List<ModeloDiasTreino>? diasSelecionado,
  }) {
    return DoencaState(
      status: status ?? this.status,
      doenca: doenca ?? this.doenca,
      doencaSelecionado: doencaSelecionado ?? this.doencaSelecionado,
      dias: dias ?? this.dias,
      diasSelecionado: diasSelecionado ?? this.diasSelecionado,
    );
  }

  @override
  List<Object?> get props => [status, doenca];
  DoencaState.initial()
      : status = DoencaStateStatus.initial,
        doenca = const [],
        doencaSelecionado = [],
        dias = const [],
        diasSelecionado = [];
}
