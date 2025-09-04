// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_state.dart';

// **************************************************************************
// MatchExtensionGenerator
// **************************************************************************

extension RegisterStatusMatch on RegisterStatus {
  T match<T>(
      {required T Function() initial,
      required T Function() loading,
      required T Function() loaded,
      required T Function() success,
      required T Function() refresh,
      required T Function() failure}) {
    final v = this;
    if (v == RegisterStatus.initial) {
      return initial();
    }

    if (v == RegisterStatus.loading) {
      return loading();
    }

    if (v == RegisterStatus.loaded) {
      return loaded();
    }

    if (v == RegisterStatus.success) {
      return success();
    }

    if (v == RegisterStatus.refresh) {
      return refresh();
    }

    if (v == RegisterStatus.failure) {
      return failure();
    }

    throw Exception('RegisterStatus.match failed, found no match for: $this');
  }

  T matchAny<T>(
      {required T Function() any,
      T Function()? initial,
      T Function()? loading,
      T Function()? loaded,
      T Function()? success,
      T Function()? refresh,
      T Function()? failure}) {
    final v = this;
    if (v == RegisterStatus.initial && initial != null) {
      return initial();
    }

    if (v == RegisterStatus.loading && loading != null) {
      return loading();
    }

    if (v == RegisterStatus.loaded && loaded != null) {
      return loaded();
    }

    if (v == RegisterStatus.success && success != null) {
      return success();
    }

    if (v == RegisterStatus.refresh && refresh != null) {
      return refresh();
    }

    if (v == RegisterStatus.failure && failure != null) {
      return failure();
    }

    return any();
  }
}
