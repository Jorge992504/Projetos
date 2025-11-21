// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'convenio_state.dart';

// **************************************************************************
// MatchExtensionGenerator
// **************************************************************************

extension ConvenioStatusMatch on ConvenioStatus {
  T match<T>(
      {required T Function() initial,
      required T Function() loading,
      required T Function() loaded,
      required T Function() success,
      required T Function() failure}) {
    final v = this;
    if (v == ConvenioStatus.initial) {
      return initial();
    }

    if (v == ConvenioStatus.loading) {
      return loading();
    }

    if (v == ConvenioStatus.loaded) {
      return loaded();
    }

    if (v == ConvenioStatus.success) {
      return success();
    }

    if (v == ConvenioStatus.failure) {
      return failure();
    }

    throw Exception('ConvenioStatus.match failed, found no match for: $this');
  }

  T matchAny<T>(
      {required T Function() any,
      T Function()? initial,
      T Function()? loading,
      T Function()? loaded,
      T Function()? success,
      T Function()? failure}) {
    final v = this;
    if (v == ConvenioStatus.initial && initial != null) {
      return initial();
    }

    if (v == ConvenioStatus.loading && loading != null) {
      return loading();
    }

    if (v == ConvenioStatus.loaded && loaded != null) {
      return loaded();
    }

    if (v == ConvenioStatus.success && success != null) {
      return success();
    }

    if (v == ConvenioStatus.failure && failure != null) {
      return failure();
    }

    return any();
  }
}
