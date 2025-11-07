// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'atendimento_state.dart';

// **************************************************************************
// MatchExtensionGenerator
// **************************************************************************

extension AtendimentoStatusMatch on AtendimentoStatus {
  T match<T>(
      {required T Function() initial,
      required T Function() loading,
      required T Function() loaded,
      required T Function() success,
      required T Function() failure}) {
    final v = this;
    if (v == AtendimentoStatus.initial) {
      return initial();
    }

    if (v == AtendimentoStatus.loading) {
      return loading();
    }

    if (v == AtendimentoStatus.loaded) {
      return loaded();
    }

    if (v == AtendimentoStatus.success) {
      return success();
    }

    if (v == AtendimentoStatus.failure) {
      return failure();
    }

    throw Exception(
        'AtendimentoStatus.match failed, found no match for: $this');
  }

  T matchAny<T>(
      {required T Function() any,
      T Function()? initial,
      T Function()? loading,
      T Function()? loaded,
      T Function()? success,
      T Function()? failure}) {
    final v = this;
    if (v == AtendimentoStatus.initial && initial != null) {
      return initial();
    }

    if (v == AtendimentoStatus.loading && loading != null) {
      return loading();
    }

    if (v == AtendimentoStatus.loaded && loaded != null) {
      return loaded();
    }

    if (v == AtendimentoStatus.success && success != null) {
      return success();
    }

    if (v == AtendimentoStatus.failure && failure != null) {
      return failure();
    }

    return any();
  }
}
