// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_state.dart';

// **************************************************************************
// MatchExtensionGenerator
// **************************************************************************

extension HomeStatusMatch on HomeStatus {
  T match<T>(
      {required T Function() initial,
      required T Function() loading,
      required T Function() loaded,
      required T Function() refresh,
      required T Function() failure,
      required T Function() atualizaSacola,
      required T Function() removerProduto}) {
    final v = this;
    if (v == HomeStatus.initial) {
      return initial();
    }

    if (v == HomeStatus.loading) {
      return loading();
    }

    if (v == HomeStatus.loaded) {
      return loaded();
    }

    if (v == HomeStatus.refresh) {
      return refresh();
    }

    if (v == HomeStatus.failure) {
      return failure();
    }

    if (v == HomeStatus.atualizaSacola) {
      return atualizaSacola();
    }

    if (v == HomeStatus.removerProduto) {
      return removerProduto();
    }

    throw Exception('HomeStatus.match failed, found no match for: $this');
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
    if (v == HomeStatus.initial && initial != null) {
      return initial();
    }

    if (v == HomeStatus.loading && loading != null) {
      return loading();
    }

    if (v == HomeStatus.loaded && loaded != null) {
      return loaded();
    }

    if (v == HomeStatus.refresh && refresh != null) {
      return refresh();
    }

    if (v == HomeStatus.failure && failure != null) {
      return failure();
    }

    if (v == HomeStatus.atualizaSacola && atualizaSacola != null) {
      return atualizaSacola();
    }

    if (v == HomeStatus.removerProduto && removerProduto != null) {
      return removerProduto();
    }

    return any();
  }
}
