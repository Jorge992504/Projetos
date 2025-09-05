// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'redefine_password_state.dart';

// **************************************************************************
// MatchExtensionGenerator
// **************************************************************************

extension RedefinePasswordStatusMatch on RedefinePasswordStatus {
  T match<T>(
      {required T Function() initial,
      required T Function() loading,
      required T Function() loaded,
      required T Function() success,
      required T Function() refresh,
      required T Function() failure}) {
    final v = this;
    if (v == RedefinePasswordStatus.initial) {
      return initial();
    }

    if (v == RedefinePasswordStatus.loading) {
      return loading();
    }

    if (v == RedefinePasswordStatus.loaded) {
      return loaded();
    }

    if (v == RedefinePasswordStatus.success) {
      return success();
    }

    if (v == RedefinePasswordStatus.refresh) {
      return refresh();
    }

    if (v == RedefinePasswordStatus.failure) {
      return failure();
    }

    throw Exception(
        'RedefinePasswordStatus.match failed, found no match for: $this');
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
    if (v == RedefinePasswordStatus.initial && initial != null) {
      return initial();
    }

    if (v == RedefinePasswordStatus.loading && loading != null) {
      return loading();
    }

    if (v == RedefinePasswordStatus.loaded && loaded != null) {
      return loaded();
    }

    if (v == RedefinePasswordStatus.success && success != null) {
      return success();
    }

    if (v == RedefinePasswordStatus.refresh && refresh != null) {
      return refresh();
    }

    if (v == RedefinePasswordStatus.failure && failure != null) {
      return failure();
    }

    return any();
  }
}
