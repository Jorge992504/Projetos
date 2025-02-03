// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'treino_state.dart';

// **************************************************************************
// MatchExtensionGenerator
// **************************************************************************

extension TreinoStateStatusMatch on TreinoStateStatus {
  T match<T>(
      {required T Function() initial,
      required T Function() loading,
      required T Function() loaded,
      required T Function() error,
      required T Function() success,
      required T Function() register}) {
    final v = this;
    if (v == TreinoStateStatus.initial) {
      return initial();
    }

    if (v == TreinoStateStatus.loading) {
      return loading();
    }

    if (v == TreinoStateStatus.loaded) {
      return loaded();
    }

    if (v == TreinoStateStatus.error) {
      return error();
    }

    if (v == TreinoStateStatus.success) {
      return success();
    }

    if (v == TreinoStateStatus.register) {
      return register();
    }

    throw Exception(
        'TreinoStateStatus.match failed, found no match for: $this');
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
    if (v == TreinoStateStatus.initial && initial != null) {
      return initial();
    }

    if (v == TreinoStateStatus.loading && loading != null) {
      return loading();
    }

    if (v == TreinoStateStatus.loaded && loaded != null) {
      return loaded();
    }

    if (v == TreinoStateStatus.error && error != null) {
      return error();
    }

    if (v == TreinoStateStatus.success && success != null) {
      return success();
    }

    if (v == TreinoStateStatus.register && register != null) {
      return register();
    }

    return any();
  }
}
