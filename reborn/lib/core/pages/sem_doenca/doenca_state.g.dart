// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doenca_state.dart';

// **************************************************************************
// MatchExtensionGenerator
// **************************************************************************

extension DoencaStateStatusMatch on DoencaStateStatus {
  T match<T>(
      {required T Function() initial,
      required T Function() loading,
      required T Function() loaded,
      required T Function() error,
      required T Function() success,
      required T Function() register}) {
    final v = this;
    if (v == DoencaStateStatus.initial) {
      return initial();
    }

    if (v == DoencaStateStatus.loading) {
      return loading();
    }

    if (v == DoencaStateStatus.loaded) {
      return loaded();
    }

    if (v == DoencaStateStatus.error) {
      return error();
    }

    if (v == DoencaStateStatus.success) {
      return success();
    }

    if (v == DoencaStateStatus.register) {
      return register();
    }

    throw Exception(
        'DoencaStateStatus.match failed, found no match for: $this');
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
    if (v == DoencaStateStatus.initial && initial != null) {
      return initial();
    }

    if (v == DoencaStateStatus.loading && loading != null) {
      return loading();
    }

    if (v == DoencaStateStatus.loaded && loaded != null) {
      return loaded();
    }

    if (v == DoencaStateStatus.error && error != null) {
      return error();
    }

    if (v == DoencaStateStatus.success && success != null) {
      return success();
    }

    if (v == DoencaStateStatus.register && register != null) {
      return register();
    }

    return any();
  }
}
