// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ses1184i_state.dart';

// **************************************************************************
// MatchExtensionGenerator
// **************************************************************************

extension Ses1184iStatusMatch on Ses1184iStatus {
  T match<T>(
      {required T Function() initial,
      required T Function() loading,
      required T Function() loaded,
      required T Function() failure,
      required T Function() success}) {
    final v = this;
    if (v == Ses1184iStatus.initial) {
      return initial();
    }

    if (v == Ses1184iStatus.loading) {
      return loading();
    }

    if (v == Ses1184iStatus.loaded) {
      return loaded();
    }

    if (v == Ses1184iStatus.failure) {
      return failure();
    }

    if (v == Ses1184iStatus.success) {
      return success();
    }

    throw Exception('Ses1184iStatus.match failed, found no match for: $this');
  }

  T matchAny<T>(
      {required T Function() any,
      T Function()? initial,
      T Function()? loading,
      T Function()? loaded,
      T Function()? failure,
      T Function()? success}) {
    final v = this;
    if (v == Ses1184iStatus.initial && initial != null) {
      return initial();
    }

    if (v == Ses1184iStatus.loading && loading != null) {
      return loading();
    }

    if (v == Ses1184iStatus.loaded && loaded != null) {
      return loaded();
    }

    if (v == Ses1184iStatus.failure && failure != null) {
      return failure();
    }

    if (v == Ses1184iStatus.success && success != null) {
      return success();
    }

    return any();
  }
}
