// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_state.dart';

// **************************************************************************
// MatchExtensionGenerator
// **************************************************************************

extension LoginStatusMatch on LoginStatus {
  T match<T>(
      {required T Function() initial,
      required T Function() loading,
      required T Function() loaded,
      required T Function() sucess,
      required T Function() failure}) {
    final v = this;
    if (v == LoginStatus.initial) {
      return initial();
    }

    if (v == LoginStatus.loading) {
      return loading();
    }

    if (v == LoginStatus.loaded) {
      return loaded();
    }

    if (v == LoginStatus.sucess) {
      return sucess();
    }

    if (v == LoginStatus.failure) {
      return failure();
    }

    throw Exception('LoginStatus.match failed, found no match for: $this');
  }

  T matchAny<T>(
      {required T Function() any,
      T Function()? initial,
      T Function()? loading,
      T Function()? loaded,
      T Function()? sucess,
      T Function()? failure}) {
    final v = this;
    if (v == LoginStatus.initial && initial != null) {
      return initial();
    }

    if (v == LoginStatus.loading && loading != null) {
      return loading();
    }

    if (v == LoginStatus.loaded && loaded != null) {
      return loaded();
    }

    if (v == LoginStatus.sucess && sucess != null) {
      return sucess();
    }

    if (v == LoginStatus.failure && failure != null) {
      return failure();
    }

    return any();
  }
}
