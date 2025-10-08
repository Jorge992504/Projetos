// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'editar_empresa_state.dart';

// **************************************************************************
// MatchExtensionGenerator
// **************************************************************************

extension EditarEmpresaStatusMatch on EditarEmpresaStatus {
  T match<T>(
      {required T Function() initial,
      required T Function() loading,
      required T Function() loaded,
      required T Function() success,
      required T Function() failure}) {
    final v = this;
    if (v == EditarEmpresaStatus.initial) {
      return initial();
    }

    if (v == EditarEmpresaStatus.loading) {
      return loading();
    }

    if (v == EditarEmpresaStatus.loaded) {
      return loaded();
    }

    if (v == EditarEmpresaStatus.success) {
      return success();
    }

    if (v == EditarEmpresaStatus.failure) {
      return failure();
    }

    throw Exception(
        'EditarEmpresaStatus.match failed, found no match for: $this');
  }

  T matchAny<T>(
      {required T Function() any,
      T Function()? initial,
      T Function()? loading,
      T Function()? loaded,
      T Function()? success,
      T Function()? failure}) {
    final v = this;
    if (v == EditarEmpresaStatus.initial && initial != null) {
      return initial();
    }

    if (v == EditarEmpresaStatus.loading && loading != null) {
      return loading();
    }

    if (v == EditarEmpresaStatus.loaded && loaded != null) {
      return loaded();
    }

    if (v == EditarEmpresaStatus.success && success != null) {
      return success();
    }

    if (v == EditarEmpresaStatus.failure && failure != null) {
      return failure();
    }

    return any();
  }
}
