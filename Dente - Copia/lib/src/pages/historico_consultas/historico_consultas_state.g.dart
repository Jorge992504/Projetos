// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'historico_consultas_state.dart';

// **************************************************************************
// MatchExtensionGenerator
// **************************************************************************

extension HistoricoConsultasStatusMatch on HistoricoConsultasStatus {
  T match<T>(
      {required T Function() initial,
      required T Function() loading,
      required T Function() loaded,
      required T Function() success,
      required T Function() failure}) {
    final v = this;
    if (v == HistoricoConsultasStatus.initial) {
      return initial();
    }

    if (v == HistoricoConsultasStatus.loading) {
      return loading();
    }

    if (v == HistoricoConsultasStatus.loaded) {
      return loaded();
    }

    if (v == HistoricoConsultasStatus.success) {
      return success();
    }

    if (v == HistoricoConsultasStatus.failure) {
      return failure();
    }

    throw Exception(
        'HistoricoConsultasStatus.match failed, found no match for: $this');
  }

  T matchAny<T>(
      {required T Function() any,
      T Function()? initial,
      T Function()? loading,
      T Function()? loaded,
      T Function()? success,
      T Function()? failure}) {
    final v = this;
    if (v == HistoricoConsultasStatus.initial && initial != null) {
      return initial();
    }

    if (v == HistoricoConsultasStatus.loading && loading != null) {
      return loading();
    }

    if (v == HistoricoConsultasStatus.loaded && loaded != null) {
      return loaded();
    }

    if (v == HistoricoConsultasStatus.success && success != null) {
      return success();
    }

    if (v == HistoricoConsultasStatus.failure && failure != null) {
      return failure();
    }

    return any();
  }
}
