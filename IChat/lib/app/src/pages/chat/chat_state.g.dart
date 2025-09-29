// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_state.dart';

// **************************************************************************
// MatchExtensionGenerator
// **************************************************************************

extension ChatStatusMatch on ChatStatus {
  T match<T>(
      {required T Function() initial,
      required T Function() loading,
      required T Function() loaded,
      required T Function() send,
      required T Function() error}) {
    final v = this;
    if (v == ChatStatus.initial) {
      return initial();
    }

    if (v == ChatStatus.loading) {
      return loading();
    }

    if (v == ChatStatus.loaded) {
      return loaded();
    }

    if (v == ChatStatus.send) {
      return send();
    }

    if (v == ChatStatus.error) {
      return error();
    }

    throw Exception('ChatStatus.match failed, found no match for: $this');
  }

  T matchAny<T>(
      {required T Function() any,
      T Function()? initial,
      T Function()? loading,
      T Function()? loaded,
      T Function()? send,
      T Function()? error}) {
    final v = this;
    if (v == ChatStatus.initial && initial != null) {
      return initial();
    }

    if (v == ChatStatus.loading && loading != null) {
      return loading();
    }

    if (v == ChatStatus.loaded && loaded != null) {
      return loaded();
    }

    if (v == ChatStatus.send && send != null) {
      return send();
    }

    if (v == ChatStatus.error && error != null) {
      return error();
    }

    return any();
  }
}
