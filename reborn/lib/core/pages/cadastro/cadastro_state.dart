// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:match/match.dart';

part 'cadastro_state.g.dart';

@match
enum CadastroStatus {
  initial,
  register,
  success,
  error,
}

class CadastrarState {
  final CadastroStatus status;

  CadastrarState({required this.status});

  CadastrarState.initial() : status = CadastroStatus.initial;

  CadastrarState copyWith({
    CadastroStatus? status,
  }) {
    return CadastrarState(
      status: status ?? this.status,
    );
  }
}
