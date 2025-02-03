// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dias_treino_state.dart';

// **************************************************************************
// MatchExtensionGenerator
// **************************************************************************

extension DiasTreinoStateStatusMatch on DiasTreinoStateStatus {
  T match<T>(
      {required T Function() initial,
      required T Function() loading,
      required T Function() loaded,
      required T Function() error,
      required T Function() success,
      required T Function() register}) {
    final v = this;
    if (v == DiasTreinoStateStatus.initial) {
      return initial();
    }

    if (v == DiasTreinoStateStatus.loading) {
      return loading();
    }

    if (v == DiasTreinoStateStatus.loaded) {
      return loaded();
    }

    if (v == DiasTreinoStateStatus.error) {
      return error();
    }

    if (v == DiasTreinoStateStatus.success) {
      return success();
    }

    if (v == DiasTreinoStateStatus.register) {
      return register();
    }

    throw Exception(
        'DiasTreinoStateStatus.match failed, found no match for: $this');
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
    if (v == DiasTreinoStateStatus.initial && initial != null) {
      return initial();
    }

    if (v == DiasTreinoStateStatus.loading && loading != null) {
      return loading();
    }

    if (v == DiasTreinoStateStatus.loaded && loaded != null) {
      return loaded();
    }

    if (v == DiasTreinoStateStatus.error && error != null) {
      return error();
    }

    if (v == DiasTreinoStateStatus.success && success != null) {
      return success();
    }

    if (v == DiasTreinoStateStatus.register && register != null) {
      return register();
    }

    return any();
  }
}
