// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dentista_state.dart';

// **************************************************************************
// MatchExtensionGenerator
// **************************************************************************

extension DentistaStatusMatch on DentistaStatus {
  T match<T>(
      {required T Function() initial,
      required T Function() loading,
      required T Function() loaded,
      required T Function() success,
      required T Function() failure}) {
    final v = this;
    if (v == DentistaStatus.initial) {
      return initial();
    }

    if (v == DentistaStatus.loading) {
      return loading();
    }

    if (v == DentistaStatus.loaded) {
      return loaded();
    }

    if (v == DentistaStatus.success) {
      return success();
    }

    if (v == DentistaStatus.failure) {
      return failure();
    }

    throw Exception('DentistaStatus.match failed, found no match for: $this');
  }

  T matchAny<T>(
      {required T Function() any,
      T Function()? initial,
      T Function()? loading,
      T Function()? loaded,
      T Function()? success,
      T Function()? failure}) {
    final v = this;
    if (v == DentistaStatus.initial && initial != null) {
      return initial();
    }

    if (v == DentistaStatus.loading && loading != null) {
      return loading();
    }

    if (v == DentistaStatus.loaded && loaded != null) {
      return loaded();
    }

    if (v == DentistaStatus.success && success != null) {
      return success();
    }

    if (v == DentistaStatus.failure && failure != null) {
      return failure();
    }

    return any();
  }
}
