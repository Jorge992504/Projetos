// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'relatorio_state.dart';

// **************************************************************************
// MatchExtensionGenerator
// **************************************************************************

extension RelatorioStatusMatch on RelatorioStatus {
  T match<T>(
      {required T Function() initial,
      required T Function() loading,
      required T Function() loaded,
      required T Function() success,
      required T Function() failure}) {
    final v = this;
    if (v == RelatorioStatus.initial) {
      return initial();
    }

    if (v == RelatorioStatus.loading) {
      return loading();
    }

    if (v == RelatorioStatus.loaded) {
      return loaded();
    }

    if (v == RelatorioStatus.success) {
      return success();
    }

    if (v == RelatorioStatus.failure) {
      return failure();
    }

    throw Exception('RelatorioStatus.match failed, found no match for: $this');
  }

  T matchAny<T>(
      {required T Function() any,
      T Function()? initial,
      T Function()? loading,
      T Function()? loaded,
      T Function()? success,
      T Function()? failure}) {
    final v = this;
    if (v == RelatorioStatus.initial && initial != null) {
      return initial();
    }

    if (v == RelatorioStatus.loading && loading != null) {
      return loading();
    }

    if (v == RelatorioStatus.loaded && loaded != null) {
      return loaded();
    }

    if (v == RelatorioStatus.success && success != null) {
      return success();
    }

    if (v == RelatorioStatus.failure && failure != null) {
      return failure();
    }

    return any();
  }
}
