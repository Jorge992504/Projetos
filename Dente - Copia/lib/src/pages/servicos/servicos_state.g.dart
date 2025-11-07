// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'servicos_state.dart';

// **************************************************************************
// MatchExtensionGenerator
// **************************************************************************

extension ServicosStatusMatch on ServicosStatus {
  T match<T>(
      {required T Function() initial,
      required T Function() loading,
      required T Function() loaded,
      required T Function() success,
      required T Function() failure}) {
    final v = this;
    if (v == ServicosStatus.initial) {
      return initial();
    }

    if (v == ServicosStatus.loading) {
      return loading();
    }

    if (v == ServicosStatus.loaded) {
      return loaded();
    }

    if (v == ServicosStatus.success) {
      return success();
    }

    if (v == ServicosStatus.failure) {
      return failure();
    }

    throw Exception('ServicosStatus.match failed, found no match for: $this');
  }

  T matchAny<T>(
      {required T Function() any,
      T Function()? initial,
      T Function()? loading,
      T Function()? loaded,
      T Function()? success,
      T Function()? failure}) {
    final v = this;
    if (v == ServicosStatus.initial && initial != null) {
      return initial();
    }

    if (v == ServicosStatus.loading && loading != null) {
      return loading();
    }

    if (v == ServicosStatus.loaded && loaded != null) {
      return loaded();
    }

    if (v == ServicosStatus.success && success != null) {
      return success();
    }

    if (v == ServicosStatus.failure && failure != null) {
      return failure();
    }

    return any();
  }
}
