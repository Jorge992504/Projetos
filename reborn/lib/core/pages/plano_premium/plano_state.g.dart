// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plano_state.dart';

// **************************************************************************
// MatchExtensionGenerator
// **************************************************************************

extension PlanoStatusMatch on PlanoStatus {
  T match<T>(
      {required T Function() initial,
      required T Function() loaded,
      required T Function() loading,
      required T Function() updateOrder,
      required T Function() error,
      required T Function() confirmRemoveProduto,
      required T Function() emptyBag,
      required T Function() success}) {
    final v = this;
    if (v == PlanoStatus.initial) {
      return initial();
    }

    if (v == PlanoStatus.loaded) {
      return loaded();
    }

    if (v == PlanoStatus.loading) {
      return loading();
    }

    if (v == PlanoStatus.updateOrder) {
      return updateOrder();
    }

    if (v == PlanoStatus.error) {
      return error();
    }

    if (v == PlanoStatus.confirmRemoveProduto) {
      return confirmRemoveProduto();
    }

    if (v == PlanoStatus.emptyBag) {
      return emptyBag();
    }

    if (v == PlanoStatus.success) {
      return success();
    }

    throw Exception('PlanoStatus.match failed, found no match for: $this');
  }

  T matchAny<T>(
      {required T Function() any,
      T Function()? initial,
      T Function()? loaded,
      T Function()? loading,
      T Function()? updateOrder,
      T Function()? error,
      T Function()? confirmRemoveProduto,
      T Function()? emptyBag,
      T Function()? success}) {
    final v = this;
    if (v == PlanoStatus.initial && initial != null) {
      return initial();
    }

    if (v == PlanoStatus.loaded && loaded != null) {
      return loaded();
    }

    if (v == PlanoStatus.loading && loading != null) {
      return loading();
    }

    if (v == PlanoStatus.updateOrder && updateOrder != null) {
      return updateOrder();
    }

    if (v == PlanoStatus.error && error != null) {
      return error();
    }

    if (v == PlanoStatus.confirmRemoveProduto && confirmRemoveProduto != null) {
      return confirmRemoveProduto();
    }

    if (v == PlanoStatus.emptyBag && emptyBag != null) {
      return emptyBag();
    }

    if (v == PlanoStatus.success && success != null) {
      return success();
    }

    return any();
  }
}
