// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agendamento_state.dart';

// **************************************************************************
// MatchExtensionGenerator
// **************************************************************************

extension AgendamentoStatusMatch on AgendamentoStatus {
  T match<T>(
      {required T Function() initial,
      required T Function() loading,
      required T Function() loaded,
      required T Function() success,
      required T Function() failure}) {
    final v = this;
    if (v == AgendamentoStatus.initial) {
      return initial();
    }

    if (v == AgendamentoStatus.loading) {
      return loading();
    }

    if (v == AgendamentoStatus.loaded) {
      return loaded();
    }

    if (v == AgendamentoStatus.success) {
      return success();
    }

    if (v == AgendamentoStatus.failure) {
      return failure();
    }

    throw Exception(
        'AgendamentoStatus.match failed, found no match for: $this');
  }

  T matchAny<T>(
      {required T Function() any,
      T Function()? initial,
      T Function()? loading,
      T Function()? loaded,
      T Function()? success,
      T Function()? failure}) {
    final v = this;
    if (v == AgendamentoStatus.initial && initial != null) {
      return initial();
    }

    if (v == AgendamentoStatus.loading && loading != null) {
      return loading();
    }

    if (v == AgendamentoStatus.loaded && loaded != null) {
      return loaded();
    }

    if (v == AgendamentoStatus.success && success != null) {
      return success();
    }

    if (v == AgendamentoStatus.failure && failure != null) {
      return failure();
    }

    return any();
  }
}
