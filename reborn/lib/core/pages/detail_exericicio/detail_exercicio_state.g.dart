// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_exercicio_state.dart';

// **************************************************************************
// MatchExtensionGenerator
// **************************************************************************

extension DetailExercicioStateStatusMatch on DetailExercicioStateStatus {
  T match<T>(
      {required T Function() initial,
      required T Function() loading,
      required T Function() loaded,
      required T Function() error,
      required T Function() success,
      required T Function() register}) {
    final v = this;
    if (v == DetailExercicioStateStatus.initial) {
      return initial();
    }

    if (v == DetailExercicioStateStatus.loading) {
      return loading();
    }

    if (v == DetailExercicioStateStatus.loaded) {
      return loaded();
    }

    if (v == DetailExercicioStateStatus.error) {
      return error();
    }

    if (v == DetailExercicioStateStatus.success) {
      return success();
    }

    if (v == DetailExercicioStateStatus.register) {
      return register();
    }

    throw Exception(
        'DetailExercicioStateStatus.match failed, found no match for: $this');
  }

  T matchAny<T>(
      {required T Function() any,
      T Function()? initial,
      T Function()? loading,
      T Function()? loaded,
      T Function()? error,
      T Function()? success,
      T Function()? register}) {
    final v = this;
    if (v == DetailExercicioStateStatus.initial && initial != null) {
      return initial();
    }

    if (v == DetailExercicioStateStatus.loading && loading != null) {
      return loading();
    }

    if (v == DetailExercicioStateStatus.loaded && loaded != null) {
      return loaded();
    }

    if (v == DetailExercicioStateStatus.error && error != null) {
      return error();
    }

    if (v == DetailExercicioStateStatus.success && success != null) {
      return success();
    }

    if (v == DetailExercicioStateStatus.register && register != null) {
      return register();
    }

    return any();
  }
}
