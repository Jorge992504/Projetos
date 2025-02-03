// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:activovo/src/models/model_disease.dart';

enum TreinoComDoencasStateStatus {
  loaded,
  error,
}

class TreinoComDoencasState {
  final TreinoComDoencasStateStatus status;
  final List<ModelDisease> doencas;

  TreinoComDoencasState({
    required this.status,
    required this.doencas,
  });

  TreinoComDoencasState copyWith({
    TreinoComDoencasStateStatus? status,
    List<ModelDisease>? doencas,
  }) {
    return TreinoComDoencasState(
      status: status ?? this.status,
      doencas: doencas ?? this.doencas,
    );
  }
}
