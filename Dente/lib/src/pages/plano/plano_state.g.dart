// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plano_state.dart';

// **************************************************************************
// MatchExtensionGenerator
// **************************************************************************

extension PlanoStatusMatch on PlanoStatus {
  T match<T>(
      {required T Function() initial,
      required T Function() loading,
      required T Function() loaded,
      required T Function() success,
      required T Function() failure}) {
    final v = this;
    if (v == PlanoStatus.initial) {
      return initial();
    }

    if (v == PlanoStatus.loading) {
      return loading();
    }

    if (v == PlanoStatus.loaded) {
      return loaded();
    }

    if (v == PlanoStatus.success) {
      return success();
    }

    if (v == PlanoStatus.failure) {
      return failure();
    }

    throw Exception('PlanoStatus.match failed, found no match for: $this');
  }

  T matchAny<T>(
      {required T Function() any,
      T Function()? initial,
      T Function()? loading,
      T Function()? loaded,
      T Function()? success,
      T Function()? failure}) {
    final v = this;
    if (v == PlanoStatus.initial && initial != null) {
      return initial();
    }

    if (v == PlanoStatus.loading && loading != null) {
      return loading();
    }

    if (v == PlanoStatus.loaded && loaded != null) {
      return loaded();
    }

    if (v == PlanoStatus.success && success != null) {
      return success();
    }

    if (v == PlanoStatus.failure && failure != null) {
      return failure();
    }

    return any();
  }
}
