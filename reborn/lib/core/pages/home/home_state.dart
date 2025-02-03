// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:reborn/core/modelos/modelo_exercicios.dart';

enum HomeStateStatus {
  initial,
  loading,
  loaded,
}

class HomeState extends Equatable {
  final HomeStateStatus status;
  final List<ModeloExercicio> exe;
  const HomeState({
    required this.status,
    required this.exe,
  });

  const HomeState.initial()
      : status = HomeStateStatus.initial,
        exe = const [];
  @override
  List<Object?> get props => [status, exe];

  HomeState copyWith({
    HomeStateStatus? status,
    List<ModeloExercicio>? exe,
  }) {
    return HomeState(
      status: status ?? this.status,
      exe: exe ?? this.exe,
    );
  }
}
