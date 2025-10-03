// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_state.dart';

// **************************************************************************
// MatchExtensionGenerator
// **************************************************************************

extension MenuStatusMatch on MenuStatus {
  T match<T>(
      {required T Function() initial,
      required T Function() loading,
      required T Function() loaded,
      required T Function() refresh,
      required T Function() failure,
      required T Function() atualizaSacola,
      required T Function() removerProduto}) {
    final v = this;
    if (v == MenuStatus.initial) {
      return initial();
    }

    if (v == MenuStatus.loading) {
      return loading();
    }

    if (v == MenuStatus.loaded) {
      return loaded();
    }

    if (v == MenuStatus.refresh) {
      return refresh();
    }

    if (v == MenuStatus.failure) {
      return failure();
    }

    if (v == MenuStatus.atualizaSacola) {
      return atualizaSacola();
    }

    if (v == MenuStatus.removerProduto) {
      return removerProduto();
    }

    throw Exception('MenuStatus.match failed, found no match for: $this');
  }

  T matchAny<T>(
      {required T Function() any,
      T Function()? initial,
      T Function()? loading,
      T Function()? loaded,
      T Function()? refresh,
      T Function()? failure,
      T Function()? atualizaSacola,
      T Function()? removerProduto}) {
    final v = this;
    if (v == MenuStatus.initial && initial != null) {
      return initial();
    }

    if (v == MenuStatus.loading && loading != null) {
      return loading();
    }

    if (v == MenuStatus.loaded && loaded != null) {
      return loaded();
    }

    if (v == MenuStatus.refresh && refresh != null) {
      return refresh();
    }

    if (v == MenuStatus.failure && failure != null) {
      return failure();
    }

    if (v == MenuStatus.atualizaSacola && atualizaSacola != null) {
      return atualizaSacola();
    }

    if (v == MenuStatus.removerProduto && removerProduto != null) {
      return removerProduto();
    }

    return any();
  }
}
